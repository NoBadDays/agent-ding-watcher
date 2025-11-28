# Agent Microwave Ding Watcher (Linux)

A tiny helper that plays a **microwave-style ding** whenever your agent finishes a task. Some agents cannot play audio in the sandbox, so this watcher listens for changes to a marker file on your host and plays the sound locally. It uses a event listener, so little to no CPU usage.

---

## Setup
```bash
chmod +x agent-ding-watcher.sh
```
Keep `agent-ding-watcher.sh` and `microwave-ding.wav` in the same directory. Install `inotifywait` (`inotify-tools`) and `paplay` (`pulseaudio-utils`) so the watcher can run and play audio.

---

## Usage
```bash
# In the directory containing the watcher and sound
./agent-ding-watcher.sh            # watches ./.agent-done by default

# Or point it at another file
./agent-ding-watcher.sh /tmp/agent-done
```
Leave the script running while you work. Press `Ctrl+C` to stop. You can add it to your startup/session scripts if you want it always on.

---

## Instructing agents to signal completion
Add guidance like this to your `AGENTS.md` (or equivalent):
```
- When you complete a task, after the final command you run for that task, append a timestamp to `agent-ding-watcher/.agent-done` via `date >> agent-ding-watcher/.agent-done` (only once per task).
- If you are blocked waiting on user approval for a permission request, append `waiting` to `agent-ding-watcher/.agent-done` via `echo waiting >> agent-ding-watcher/.agent-done` to signal the pause.
```

Each write triggers the ding watcher. The file can grow indefinitely; truncate or remove it anytime if you want a fresh start.

---

## Troubleshooting
- **No ding?** Ensure `inotifywait` is installed and `./agent-ding-watcher.sh` is running in the same directory as `.agent-done` (or that you passed the correct path).
- **Sound errors?** Install `pulseaudio-utils` (`paplay`). Confirm `microwave-ding.wav` exists next to the script.
- **Still quiet?** Verify your system volume/output device. You can also swap in any other `.wav` by replacing `microwave-ding.wav` in the script directory.
