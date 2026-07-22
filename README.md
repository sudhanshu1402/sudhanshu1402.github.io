# sudhanshu1402.github.io

[![Deploy](https://github.com/sudhanshu1402/sudhanshu1402.github.io/actions/workflows/deploy.yml/badge.svg)](https://github.com/sudhanshu1402/sudhanshu1402.github.io/actions/workflows/deploy.yml) [![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)

Personal engineering portfolio and project archive.

A single-page site that lists my engineering work: a handful of featured systems (queue engine, auth stack, tracing SDK, LLM pipeline) up top, then a searchable archive of 90 projects across 10 languages and domains like systems, ML/AI, and databases. Everything renders from one JavaScript data file. No framework, no build step.

## Live

[sudhanshu1402.github.io](https://sudhanshu1402.github.io)

## How it works

Two files do the work:

- `index.html` — the whole UI in one file: inline CSS, inline JS, no external scripts beyond Google Fonts. Handles the hero, the three project sections, category filters, live search, an accessible detail modal (focus trap, Escape to close, restores focus on close), and a light/dark toggle that persists to `localStorage`.
- `projects_data.js` — the single source of truth. Exposes a global `PROJECT_DATA` array; each entry is a plain object (`name`, `category`, `type`, `difficulty`, `actionUrl`, `actionText`, and an optional `tier`).

At load, the script partitions `PROJECT_DATA` by `tier`:

- `tier: "showcase"` → **Featured systems** (currently 4)
- `tier: "secondary"` → **Reference implementations** (currently 2)
- everything else → **Learning archive** (currently 84), the only section with search and category chips

Hero stat counters (total projects, categories, featured count) and section subtitles are all derived from the array at runtime, so they never drift from the data.

## Stack

- Vanilla HTML, CSS, JavaScript. No dependencies, no bundler.
- Google Fonts (Inter, Space Grotesk, JetBrains Mono).
- GitHub Pages for hosting; `.nojekyll` so the static files are served as-is.

## Run locally

No build. Open `index.html` in a browser, or serve the folder:

```bash
python3 -m http.server 8000
# then open http://localhost:8000
```

## Deploy

`.github/workflows/deploy.yml` publishes to GitHub Pages on every push to `main` (and via manual `workflow_dispatch`). It uploads the repo root as the Pages artifact — no build stage.

## Add or edit a project

Append an object to `PROJECT_DATA` in `projects_data.js`:

```js
{
    name: "Rate Limiter",
    category: "Go",
    type: "Backend / CLI",
    difficulty: "Medium",
    actionUrl: "https://github.com/sudhanshu1402/engineering-projects/tree/main/go/medium/rate-limiter",
    actionText: "View Source Code"
    // omit `tier` to land in the searchable archive;
    // set tier: "showcase" or "secondary" to feature it
}
```

Counts, filters, and search pick it up automatically. Category keys like `Cpp`, `CSharp`, and `Nodejs` are mapped to display labels (`C++`, `C#`, `Node.js`) via the `LABELS` table in `index.html`. `difficulty` is only shown for showcase and secondary cards; archive cards hide it.

## Notable details

- **Zero XSS surface from data.** Every field pulled from `PROJECT_DATA` is passed through an `escapeHtml` helper before it touches `innerHTML`.
- **Accessibility.** Skip link, `aria-pressed` filter chips, a real `role="dialog"` modal with focus trapping, and `prefers-reduced-motion` handling that disables the scroll-reveal animation.
- **SEO/social.** Canonical URL, Open Graph + Twitter cards, and JSON-LD `Person` structured data live in the `<head>`; `sitemap.xml` and `robots.txt` are checked in.

## Also see

- [System Design Portal](https://sudhanshu1402.github.io/system-design-portal) — architecture write-ups the featured cards link to.
- [GitHub profile](https://github.com/sudhanshu1402)
- [macOS Edition](https://sudhanshu1402.github.io/legacy-macos-portfolio/) — the same portfolio rebuilt as a fake macOS desktop, for fun (source in `legacy-macos-portfolio/`).

## License

MIT — see [LICENSE](LICENSE).
