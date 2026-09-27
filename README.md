# sudhanshu1402.github.io

[![Deploy](https://github.com/sudhanshu1402/sudhanshu1402.github.io/actions/workflows/deploy.yml/badge.svg)](https://github.com/sudhanshu1402/sudhanshu1402.github.io/actions/workflows/deploy.yml) [![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)

My engineering portfolio: one static page, no framework and no build step. Live at [sudhanshu1402.github.io](https://sudhanshu1402.github.io).

<img src="https://raw.githubusercontent.com/sudhanshu1402/sudhanshu1402.github.io/main/assets/screens/home.png" width="100%" alt="Portfolio hero on a soft aurora gradient: 'I make backends that survive the crash', beside a glass card where a keel run is killed at ship, then resumes and charges the card exactly once." />

## What is on the page

<img src="https://raw.githubusercontent.com/sudhanshu1402/sudhanshu1402.github.io/main/assets/screens/featured.png" width="100%" alt="Systems: eight cards, each with the failure it exists for and the fix, for keel, nocap, receipts, enterprise-auth-stack, distributed-queue-engine, multi-region-mongo-patterns, otel-sdk-node and llm-assessment-pipeline." />

Eight systems. Each card names the failure the repo exists for, the fix, and links to source, npm or its write-up.

<img src="https://raw.githubusercontent.com/sudhanshu1402/sudhanshu1402.github.io/main/assets/screens/archive.png" width="100%" alt="Archive: a search box, category chips with counts, and a grid of project cards." />

The archive holds every other build, with live search and category filters.

## How it works

`projects_data.js` exposes one global `PROJECT_DATA` array; entries with no `tier` fill the archive, and its counters and chips are derived from the array, so they can't drift from the data. The systems cards are defined inline in `index.html`. Everything is inline CSS and JS, styled as glass cards over a slow aurora background, every data field passes through an `esc` helper before it reaches `innerHTML`, and the theme follows the OS with a manual toggle remembered in `localStorage`.

## Run locally

```bash
python3 -m http.server 8000
```

## Checks and deploy

`deploy.yml` uploads the repo root to GitHub Pages on every push to `main`. `links.yml` runs `node scripts/check-links.mjs`, which HEAD-checks every `actionUrl` and external `href` and fails on anything that doesn't answer 2xx. It's a separate workflow on purpose: a rate-limited host should report a broken link, not block the deploy.

`scripts/make-screens.sh` regenerates the screenshots above with headless Chrome against the live site.

## Also see

- [System Design Portal](https://sudhanshu1402.github.io/system-design-portal/) for the architecture write-ups the cards link to.
- [macOS Edition](https://sudhanshu1402.github.io/legacy-macos-portfolio/), the older portfolio as a fake desktop (source in `legacy-macos-portfolio/`).
- [GitHub profile](https://github.com/sudhanshu1402).

## License

MIT, see [LICENSE](LICENSE).
