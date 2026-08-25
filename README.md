# sudhanshu1402.github.io

[![Deploy](https://github.com/sudhanshu1402/sudhanshu1402.github.io/actions/workflows/deploy.yml/badge.svg)](https://github.com/sudhanshu1402/sudhanshu1402.github.io/actions/workflows/deploy.yml) [![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)

My engineering portfolio: one static page, 92 projects, no framework and no build step. Live at [sudhanshu1402.github.io](https://sudhanshu1402.github.io).

<img src="https://raw.githubusercontent.com/sudhanshu1402/sudhanshu1402.github.io/main/assets/screens/home.png" width="100%" alt="Portfolio hero reading 'Building distributed systems that hold up in production', with counters for 92 projects, 14 categories and 6 featured projects." />

The landing view. Every number in it is counted from the data file at runtime.

## What is on the page

<img src="https://raw.githubusercontent.com/sudhanshu1402/sudhanshu1402.github.io/main/assets/screens/featured.png" width="100%" alt="Featured systems: a grid of cards for keel, nocap, Distributed Queue Engine, LLM Assessment Pipeline, Enterprise Auth Stack and System Design Portal, above the Reference implementations section." />

Six featured systems, then two reference implementations. Each card opens a detail modal or links straight to source.

<img src="https://raw.githubusercontent.com/sudhanshu1402/sudhanshu1402.github.io/main/assets/screens/archive.png" width="100%" alt="Learning archive: a search box, category chips for ML/AI, Python, Java, C, C++, Rust, Go, C#, TypeScript, Node.js and JavaScript, and a grid of project cards." />

The archive holds the other 84 builds, and it is the only section with live search and category filters.

## How it works

`projects_data.js` exposes one global `PROJECT_DATA` array. `index.html` is the whole UI in a single file: inline CSS and JS, search, filters, a `role="dialog"` modal with focus trapping, and a light/dark toggle persisted to `localStorage`. Counters, subtitles and chips are derived from the array, so they cannot drift from the data. Every field passes through an `escapeHtml` helper before it reaches `innerHTML`.

To add a project, append an object to `PROJECT_DATA`. `tier: "showcase"` or `"secondary"` features it; no `tier` means archive.

## Run locally

```bash
python3 -m http.server 8000
```

## Checks and deploy

`deploy.yml` uploads the repo root to GitHub Pages on every push to `main`. `links.yml` runs `node scripts/check-links.mjs`, which HEAD-checks every `actionUrl` and external `href` and fails on anything that does not answer 2xx. Separate workflow on purpose: a rate-limited host should report a broken link, not block the deploy.

`scripts/make-screens.sh` regenerates the screenshots above with headless Chrome against the live site. Run by hand, not gated in CI: a live capture is not byte-deterministic, so a diff check would fail every run.

## Also see

- [System Design Portal](https://sudhanshu1402.github.io/system-design-portal/) for the architecture write-ups the featured cards link to.
- [macOS Edition](https://sudhanshu1402.github.io/legacy-macos-portfolio/), the same portfolio as a fake desktop (source in `legacy-macos-portfolio/`).
- [GitHub profile](https://github.com/sudhanshu1402).

## License

MIT, see [LICENSE](LICENSE).
