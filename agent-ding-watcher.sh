#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

# Prevent duplicate instances
LOCKFILE="$SCRIPT_DIR/.agent-ding-watcher.lock"
if [ -e "$LOCKFILE" ] && kill -0 "$(cat "$LOCKFILE")" 2>/dev/null; then
  exit 0
fi
echo $$ > "$LOCKFILE"

# Change Configs Here
DEFAULT_WATCH_FILE="$SCRIPT_DIR/.agent-done"
WATCH_FILE="${1:-$DEFAULT_WATCH_FILE}"
SOUND_FILE="microwave-ding.wav"
SOUND="$SCRIPT_DIR/$SOUND_FILE"
SLEEP_SECONDS=3

fail() { echo "$1" >&2; exit 1; }

ensure_deps() {
  command -v inotifywait >/dev/null 2>&1 || fail "Missing required dependency: inotifywait (install inotify-tools)."
  SOUND_PLAYER="paplay"
  command -v "$SOUND_PLAYER" >/dev/null 2>&1 || fail "Missing audio player: install pulseaudio-utils (paplay)."
  [[ -f "$SOUND" ]] || fail "Sound file not found at $SOUND"
}

play_ding() {
  "$SOUND_PLAYER" "$SOUND" >/dev/null 2>&1 || echo "ding (sound failed)"
}

ensure_deps

touch "$WATCH_FILE"

echo "Watching $WATCH_FILE for agent completions. Using $SOUND_PLAYER with ${SLEEP_SECONDS}s delay. Ctrl+C to stop."

while inotifywait -q -e close_write "$WATCH_FILE"; do
  sleep "$SLEEP_SECONDS"
  play_ding
done
