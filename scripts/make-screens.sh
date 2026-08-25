#!/usr/bin/env bash
set -uo pipefail

CHROME="${CHROME:-/Applications/Google Chrome.app/Contents/MacOS/Google Chrome}"
SITE="${SITE:-https://sudhanshu1402.github.io/}"
OUT="$(cd "$(dirname "$0")/.." && pwd)/assets/screens"
MIN_BYTES=40000
TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT

if [ ! -x "$CHROME" ]; then
  echo "Chrome not found at: $CHROME (override with CHROME=/path/to/chrome)" >&2
  exit 1
fi

mkdir -p "$OUT"

# One-page site: sections are framed by pixel offset, since headless Chrome captures a #hash scroll mid-flight.
shot() {
  name="$1"; offset="$2"
  file="$OUT/$name.png"
  page="$TMP/$name.html"
  cat >"$page" <<HTML
<!doctype html><html><head><meta charset="utf-8"><style>
html,body{margin:0;padding:0;overflow:hidden;background:#0a0b0e}
#clip{width:1280px;height:800px;overflow:hidden;position:relative}
iframe{position:absolute;top:-${offset}px;left:0;width:1280px;height:4600px;border:0}
</style></head><body><div id="clip"><iframe src="$SITE"></iframe></div></body></html>
HTML
  for attempt in 1 2 3; do
    rm -f "$file"
    "$CHROME" --headless --disable-gpu --hide-scrollbars \
      --user-data-dir="$TMP/profile-$name-$attempt" --no-first-run --no-default-browser-check \
      --screenshot="$file" --window-size=1280,800 "file://$page" >/dev/null 2>&1 &
    pid=$!
    for _ in $(seq 1 25); do
      sleep 1
      [ -s "$file" ] && break
    done
    sleep 1
    kill -9 "$pid" >/dev/null 2>&1
    wait "$pid" 2>/dev/null
    bytes=$([ -s "$file" ] && wc -c <"$file" | tr -d ' ' || echo 0)
    [ "$bytes" -ge "$MIN_BYTES" ] && break
    echo "retrying $name (attempt $attempt gave $bytes bytes)" >&2
  done
  if [ "$bytes" -lt "$MIN_BYTES" ]; then
    echo "FAILED $name: $bytes bytes, blank render" >&2
    exit 1
  fi
  printf '%-10s offset %-5s %8s bytes\n' "$name" "$offset" "$bytes"
}

shot home 0
shot featured 800
shot archive "${ARCHIVE_OFFSET:-1820}"

echo "wrote $OUT"
