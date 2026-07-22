# Legacy macOS Portfolio

An interactive portfolio built as a working macOS desktop, in a single HTML file. This is the earlier ("legacy") version of [sudhanshu1402.github.io](https://sudhanshu1402.github.io) — kept here for reference.

## What it is

One `index.html` (~8,300 lines) that boots into a macOS-style desktop and lets you click around it like a real OS: draggable/resizable windows, a magnifying dock, a menu bar, Spotlight, a Terminal that runs commands, and a handful of working apps and games. The portfolio content (bio, skills, experience, projects, contact) lives inside those apps instead of on a scrolling page.

No framework, no build step, no npm install. Everything — layout, animation, game logic, sound, state — is hand-written HTML/CSS/JS inline in the one file.

## Running it

There's nothing to compile. Either open the file directly:

```bash
open index.html
```

or serve it over HTTP (needed so `localStorage` and fonts behave normally):

```bash
python3 -m http.server 8000
# then visit http://localhost:8000
```

## What's inside

**Desktop shell**
- Boot screen, then a desktop with menu bar, dock (with hover magnification and bounce-on-open), and draggable desktop icons
- Windows you can drag, resize, focus, maximize, and snap to screen edges
- Spotlight search, right-click context menus, dark mode toggle, custom cursor, a "Dynamic Island" notch, and notification toasts
- State that survives reloads via `localStorage`: dark mode, sticky notes, visit count, wallpaper choice, and unlocked achievements

**Apps (windows)**
- Finder, VS Code (with a file tree), Safari, About This Mac
- Terminal — see below
- Profile, Skills (animated bars), Stats, Cover Letter
- Weather (a simulated Mumbai forecast), World Clock (IST primary)
- Calculator, Sticky Notes, Pomodoro timer, Piano (playable via Web Audio)

**Terminal**

A real command loop with input history recall. Core commands:

```
help  whoami  skills  experience  projects  contact  metrics  time  clear
open [finder|vscode|games|weather|calculator|notes|piano|pomodoro]
```

Plus a pile of easter-egg commands: `ls`, `cat README.md`, `neofetch`, `cowsay`, `fortune`, `git log`, `history`, `uptime`, `ping google.com`, `vim`, `nano`, `man`, `coffee`, `sudo`, `rm -rf /`, `matrix`, `do a barrel roll`, and more. Anything the parser doesn't recognize falls through to a small offline "AI" — a regex keyword responder (no network calls, no API key) that answers questions about Sudhanshu.

**Games hub**
- Snake, 2048, Minesweeper (9×9, 10 mines), Tic Tac Toe, and Wordle

**Mobile / iOS mode**

On small screens it switches to an iOS-style interface: lock screen, Control Center, long-press menus, a multi-page springboard, a Siri/voice overlay, screen-time and battery widgets, a wallpaper picker, and a notification center.

**Extra touches (desktop)**

Ambient particles, parallax wallpaper, 3D-tilt cards, ripple click effects, a typewriter bio, an auto-typing terminal intro, a Lo-Fi music player, and sound effects — all via the Web Audio API.

## Stack

Plain HTML, CSS, and vanilla JavaScript. The only external network dependencies are Google Fonts (DM Sans, JetBrains Mono, Outfit) and two assets served from the `github.io` domain — `resume.pdf` (the Terminal/menu resume download) and wallpaper images. There are no runtime libraries.

## Notes

- Some performance care is taken deliberately: window drags drop the backdrop blur mid-drag, the clock skips its DOM rebuild when hidden, and per-frame writes are batched into `requestAnimationFrame`.
- This is a personal portfolio piece, not a component library — it's one file meant to be visited, not imported. Treat the code as a self-contained demo.
- It's labeled "legacy" because a newer portfolio has since replaced it at the live URL. Everything here still works standalone.
