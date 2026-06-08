# sudhanshu1402.github.io

Personal engineering portfolio and project archive.

A data-driven archive of engineering projects across systems, ML/AI, databases, and 10+ programming languages, organized by domain, difficulty, and type. Built with vanilla HTML, CSS, and JavaScript (zero dependencies, zero build step) and deployed via GitHub Pages.

## Live

[sudhanshu1402.github.io](https://sudhanshu1402.github.io)

## Structure

- `index.html`: portfolio shell (theme, search, category filters, accessible project modal, light/dark toggle)
- `projects_data.js`: single source of truth for all projects (`PROJECT_DATA`)
- `.github/workflows/deploy.yml`: auto-deploys `main` to GitHub Pages

To add a project, append an object to `PROJECT_DATA` in `projects_data.js`. Counts, filters, and search update automatically.

## Also See

- [System Design Portal](https://sudhanshu1402.github.io/system-design-portal): architecture breakdowns with Mermaid diagrams
- [GitHub Profile](https://github.com/sudhanshu1402): featured distributed systems projects
- [macOS Edition](https://sudhanshu1402.github.io/legacy-macos-portfolio/): just for fun, my portfolio rebuilt as a pixel-perfect macOS desktop (in `legacy-macos-portfolio/`)
