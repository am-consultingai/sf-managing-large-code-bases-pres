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

1. Click **Use this template** on GitHub to create a new repo (or copy this folder).
2. Edit **`src/presentation/slides.tsx`** — the only file you need to touch.
3. Push to `main`. Enable **Settings → Pages → Source: GitHub Actions** once.
   Your deck deploys automatically.

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
