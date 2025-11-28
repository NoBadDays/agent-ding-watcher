# Agent Microwave Ding Watcher (Linux)

A tiny helper that plays a **microwave-style ding** whenever your agent finishes a task. Some agents cannot play audio in the sandbox, so this watcher listens for changes to a marker file on your host and plays the sound locally. It uses inotify, so it sits idle until an event occurs.

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
- After finishing a task, append a timestamp to `.agent-done` (once per task):  
  ```bash
  date >> .agent-done
  ```
- If waiting on user approval/permissions, append `waiting`:  
  ```bash
  echo waiting >> .agent-done
  ```

Each write triggers the ding watcher. The file can grow indefinitely; truncate or remove it anytime if you want a fresh start.

---

## Troubleshooting
- **No ding?** Ensure `inotifywait` is installed and `./agent-ding-watcher.sh` is running in the same directory as `.agent-done` (or that you passed the correct path).
- **Sound errors?** Install `pulseaudio-utils` (`paplay`). Confirm `microwave-ding.wav` exists next to the script.
- **Still quiet?** Verify your system volume/output device. You can also swap in any other `.wav` by replacing `microwave-ding.wav` in the script directory.
