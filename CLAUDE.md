# AM Consulting — Presentation Template

This repo is a **reusable template** for building interactive, web-based
presentations on the AM Consulting brand. It is duplicated per presentation
(GitHub → **Use this template**), then each copy gets its own GitHub Pages URL.

> **If you are an agent creating a new presentation: you only edit
> `src/presentation/slides.tsx`.** Everything else (brand, engine, layouts) is
> already built and on-brand. Do not restyle slides or hardcode colors/fonts.

## Stack

Vite + React 19 + TypeScript · Tailwind CSS v4 · Motion (`motion/react`) for
animation · hash-based navigation · deploys to GitHub Pages via Actions.

## Create a new presentation (duplicate this template)

Pick one — each produces an independent repo for one talk:

```bash
# A) GitHub: click "Use this template" → new repo, then clone it.

# B) Clone without history (degit):
npx degit <owner>/<this-template-repo> my-talk && cd my-talk

# C) Plain copy:
cp -r online-pres-infra my-talk && cd my-talk && rm -rf .git && git init
```

Then: `npm install` → edit `src/presentation/slides.tsx` → `npm run dev`.
Rename the deck in `index.html` (`<title>`) and `package.json` (`name`).

## Author a deck from a content brief (the agent recipe)

1. **Read this file** and skim the example in `src/presentation/slides.tsx`.
2. **Map content to the slide arc**, typically:
   `TitleSlide` → `AboutSlide` (or `AgendaSlide`) → body slides
   (`BulletSlide` / `ProcessSlide` / `DiagramSlide` / `QuoteSlide`, with
   `SectionDivider` between sections) → `ClosingSlide`.
3. **Replace the `slides` array** in `slides.tsx` — one array entry per slide.
   Use the layouts below; do not write raw markup unless a custom slide is needed.
4. **Keep it on-brand**: never set colors/fonts; the layouts already carry them.
5. **Verify**: `npm run build` must pass, then `npm run dev` and click through.

## How to author a deck

`src/presentation/slides.tsx` exports `slides: Slide[]`. Each array entry is one
slide, composed from the branded layouts in `src/deck-kit/slides`. Reorder, add,
remove. That's it.

```tsx
import { TitleSlide, BulletSlide, ClosingSlide } from "../deck-kit/slides";

export const slides: Slide[] = [
  <TitleSlide title="My talk" highlight="title" date="Jun 2026" />,
  <BulletSlide title="Key points" bullets={["First", "Second"]} />,
  <ClosingSlide />,
];
```

Run `npm run dev`, then navigate with **→ / Space / click** (forward),
**← / click left edge** (back), **F** fullscreen, **?** help. Every slide is
deep-linkable at `#/<n>`.

## Layout reference (props are typed — hover in your editor)

| Layout | Use for | Key props |
|---|---|---|
| `TitleSlide` | Opening slide | `title`, `highlight`, `subtitle`, `eyebrow`, `date` |
| `AboutSlide` | Intro/outro "About us" bookend | `blurb`, `stats`, `services` (defaults to brand) |
| `AgendaSlide` | Table of contents | `items: string[]`, `title` |
| `BulletSlide` | Standard content; optional right-hand `aside` | `title`, `lead`, `bullets`, `aside` |
| `ProcessSlide` | Numbered sequential steps / workflow | `title`, `steps: {title, desc?}[]` |
| `DiagramSlide` | Box-and-arrow flow (A → B → C) | `title`, `nodes: {label, sub?}[]`, `caption` |
| `SectionDivider` | Transition between sections | `number`, `title`, `highlight`, `subtitle` |
| `QuoteSlide` | One large statement / tagline | `quote`, `highlight`, `attribution` |
| `ClosingSlide` | Thank-you + contact bookend | `headline`, `highlight` (defaults to brand contact) |

For anything custom, use `SlideShell` + the primitives (`Eyebrow`,
`GradientText`, `Stat`, `Stagger`, `Item`) from `../deck-kit/slides`. Wrap
revealed content in `<Stagger>` … `<Item>` so it animates in on slide enter.
**Interactive elements** (live demos, charts, forms) can be any React component
— drop them into a `BulletSlide` `aside` or a custom `SlideShell` slide.

## Brand — the rules

The brand is the **single source of truth** and must not be overridden per slide:

- Tokens: `src/deck-kit/theme/tokens.ts` (JS) and `src/index.css` `@theme` (CSS
  utilities). Authoritative spec: `references/brand/brand-tokens.json`.
- **Never hardcode hex colors or font names.** Use Tailwind utilities
  (`text-ink`, `text-cyan`, `bg-panel`, `font-display`, `brand-gradient-text`)
  or the `brand` object.
- Palette: canvas `#0b0f19` (dark), accents cyan `#22d3ee` → sky `#38bdf8` →
  indigo `#818cf8`. Fonts: Space Grotesk (display), Inter (body), JetBrains Mono
  (labels). Voice: confident, technical, no-hype; concrete numbers over buzzwords.
- Logo currently uses the legacy rook lockup in `public/brand/`. To upgrade,
  drop the official `am-logo.png` / `am_favicon.png` there and update
  `tokens.ts` asset paths + `index.html` favicon.

## Deploying

Push to `main` → the Actions workflow builds and publishes to GitHub Pages
(enable Pages → Source: "GitHub Actions" once per repo). `vite.config.ts` uses
`base: "./"` so the build works at any path without configuration.

## Layout constraints

Slides are authored against a fixed **1280×720** stage that auto-scales to the
viewport (`STAGE_WIDTH`/`STAGE_HEIGHT` in `engine/types.ts`). Design to that
canvas; the engine handles letterboxing and scaling.
