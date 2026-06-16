# AM Consulting — Interactive Presentation Template

A template for building modern, interactive, web-based presentations on the
AM Consulting brand. Built with Vite + React + TypeScript, Tailwind CSS, and
Motion. Deploys to GitHub Pages.

## Quick start

```bash
npm install
npm run dev      # http://localhost:5173
```

Navigate: **→ / Space / click** next · **←** back · **F** fullscreen · **?** help.

## Make a new presentation

One command (run from your projects directory, not inside this repo):

```bash
scripts/new-presentation.sh -n my-talk
```

This clones the template into `./my-talk`, creates a new public GitHub repo,
pushes, and enables GitHub Pages — all without touching this template repo.
Then:

1. `cd my-talk && npm install && npm run dev`
2. Edit **`src/presentation/slides.tsx`** — the only file you need to touch.
3. Push to `main` → it deploys automatically to `https://<owner>.github.io/my-talk/`.

(You can also use GitHub's **Use this template** button for a manual copy.)

See [`CLAUDE.md`](./CLAUDE.md) for the full authoring guide and layout reference
— it's also the brief an AI agent reads to build a deck for you.

## Structure

```
src/
  deck-kit/            reusable, branded toolkit (don't edit per-deck)
    theme/tokens.ts    brand colors, fonts, identity
    engine/Deck.tsx    navigation + scaling + transitions
    slides/            branded layouts (Title, Bullet, Diagram, …)
  presentation/
    slides.tsx         ← YOUR deck content
references/brand/      source brand guide, tokens, and logo assets
```

## Build

```bash
npm run build    # → dist/
npm run preview  # preview the production build
```
