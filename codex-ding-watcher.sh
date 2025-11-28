#!/usr/bin/env bash
# Usage: ./codex-ding-watcher.sh [file-to-watch]

# Directory where this script lives
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

WATCH_FILE="${1:-.codex-done}"
SOUND="$SCRIPT_DIR/microwave-ding.wav"

touch "$WATCH_FILE"

echo "Watching $WATCH_FILE for Codex completions. Ctrl+C to stop."

while inotifywait -q -e close_write "$WATCH_FILE"; do
  sleep 2
  paplay "$SOUND" 2>/dev/null || \
  aplay "$SOUND" 2>/dev/null || \
  echo "ding (sound failed)"
done
