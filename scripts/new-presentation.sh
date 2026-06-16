#!/usr/bin/env bash
#
# new-presentation.sh — scaffold a brand-new AM Consulting presentation.
#
# What it does:
#   1. Clones this template into ./<name> (a new folder inside your CURRENT
#      working directory) and detaches it from the template's git history.
#   2. Creates a NEW public GitHub repo named <name>, commits, and pushes.
#   3. Enables GitHub Pages (GitHub Actions source) so the deck deploys live.
#
# The template repository itself is never modified — it is only cloned (read).
#
# Usage:
#   new-presentation.sh -n <name>
#
# Options:
#   -n <name>   Folder + repo name (required). Allowed: letters, digits, . _ -
#   -h          Show this help.
#
# Environment overrides (optional):
#   TEMPLATE_REPO   owner/repo to clone from
#                   (default: am-consultingai/am-consulting-presentation-template)
#   GH_OWNER        account/org to create the new repo under
#                   (default: your authenticated gh login)
#
set -euo pipefail

TEMPLATE_REPO="${TEMPLATE_REPO:-am-consultingai/am-consulting-presentation-template}"

say()  { printf '\033[1;36m▸ %s\033[0m\n' "$*"; }
ok()   { printf '\033[1;32m✓ %s\033[0m\n' "$*"; }
err()  { printf '\033[1;31m✗ %s\033[0m\n' "$*" >&2; }

usage() { sed -n '2,28p' "$0" | sed 's/^# \{0,1\}//'; }

NAME=""
while getopts ":n:h" opt; do
  case "$opt" in
    n) NAME="$OPTARG" ;;
    h) usage; exit 0 ;;
    \?) err "Unknown option: -$OPTARG"; usage; exit 1 ;;
    :)  err "Option -$OPTARG requires an argument"; exit 1 ;;
  esac
done

# ---- validation ------------------------------------------------------------
[ -n "$NAME" ] || { err "Missing required -n <name>"; usage; exit 1; }
[[ "$NAME" =~ ^[A-Za-z0-9._-]+$ ]] || { err "Invalid name '$NAME' (use letters, digits, . _ -)"; exit 1; }

for tool in git gh npm; do
  command -v "$tool" >/dev/null 2>&1 || { err "'$tool' is not installed or not on PATH"; exit 1; }
done
gh auth status >/dev/null 2>&1 || { err "GitHub CLI not authenticated. Run: gh auth login"; exit 1; }

PARENT="$PWD"
TARGET="$PARENT/$NAME"

# Don't scaffold inside an existing deck/template checkout (would nest projects).
if [ -d "$PARENT/src/deck-kit" ]; then
  err "You're inside a deck-kit project ($PARENT)."
  err "cd into your projects directory first — the new deck is created in the current folder."
  exit 1
fi
[ -e "$TARGET" ] && { err "'$TARGET' already exists"; exit 1; }

OWNER="${GH_OWNER:-$(gh api user --jq .login)}"

# ---- 1. clone template (read-only) + detach history ------------------------
say "Cloning template $TEMPLATE_REPO → $NAME/"
gh repo clone "$TEMPLATE_REPO" "$TARGET" -- --depth 1 --quiet
cd "$TARGET"
rm -rf .git scripts/.git
git init -q -b main

# ---- 2. personalize ---------------------------------------------------------
TITLE="$(printf '%s' "$NAME" | tr '_-' '  ')"
sed -i "s|<title>.*</title>|<title>${TITLE} — AM Consulting</title>|" index.html
ok "Set browser title to: ${TITLE} — AM Consulting"

git add -A
git commit -q -m "Initialize presentation: $NAME (from template)"

# ---- 3. create remote repo, enable Pages, push ------------------------------
say "Creating public GitHub repo $OWNER/$NAME"
gh repo create "$OWNER/$NAME" --public --source=. --remote=origin \
  --description "AM Consulting presentation: $NAME"

enable_pages() {
  gh api --silent -X POST "repos/$OWNER/$NAME/pages" -f build_type=workflow 2>/dev/null \
    || gh api --silent -X PUT "repos/$OWNER/$NAME/pages" -f build_type=workflow 2>/dev/null
}

say "Enabling GitHub Pages (GitHub Actions source)"
PAGES_OK=0
enable_pages && PAGES_OK=1 || true

say "Pushing to origin/main"
git push -u origin main -q

# If Pages couldn't be enabled before the repo had content, enable now and
# re-run the deploy workflow so the first publish succeeds.
if [ "$PAGES_OK" -ne 1 ]; then
  sleep 2
  if enable_pages; then
    PAGES_OK=1
    RUN_ID="$(gh run list --workflow deploy.yml -L 1 --json databaseId --jq '.[0].databaseId' 2>/dev/null || true)"
    if [ -n "${RUN_ID:-}" ]; then gh run rerun "$RUN_ID" >/dev/null 2>&1 || true
    else gh workflow run deploy.yml >/dev/null 2>&1 || true; fi
  fi
fi

# ---- done -------------------------------------------------------------------
echo
ok "Presentation '$NAME' is ready."
echo "   Folder : $TARGET"
echo "   Repo   : https://github.com/$OWNER/$NAME"
if [ "$PAGES_OK" -eq 1 ]; then
  echo "   Live   : https://$OWNER.github.io/$NAME/   (first deploy ~1–2 min)"
else
  err  "Pages not auto-enabled. Enable manually:"
  echo "            gh api -X POST repos/$OWNER/$NAME/pages -f build_type=workflow"
fi
echo
echo "   Next:  cd \"$NAME\" && npm install && npm run dev"
echo "          then edit src/presentation/slides.tsx"
