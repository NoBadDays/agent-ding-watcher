# Codex Microwave Ding Watcher (Linux)

This small utility plays a **microwave-style ding** on your machine each time Codex completes a task.  
Codex itself runs in a sandbox without audio access, so this watcher listens for file changes locally and plays the sound on your host system.
This is a events based listener so uses virtually no resources. 

---

## 📂 Folder Contents

Place these two files in the same folder:

- `codex-ding-watcher.sh`
- `microwave-ding.wav`

Make codex-ding-watcher executable 

`chmod +x codex-ding-watcher.sh` 

---

## 🔧 Requirements

### 1. `inotifywait`
Used to detect when Codex writes to `.codex-done`.

Install:

`sudo apt install inotify-tools`

### 2 `pulseaudio-utils`
Used to play the .wav sound

Install:
`sudo apt install pulseaudio-utils` 

## Run ding-watcher 

`./codex-ding-watcher.sh`
You can make this run on startup, 

## Add this to agents 
Add this to your AGENTS.md file 
- When you complete a task, after the final command you run for that task, append `done` to `.codex-done` via `echo done >> .codex-done` (only once per task).
- If you are blocked waiting on user approval for a permission request, append `waiting` to `.codex-done` via `echo waiting >> .codex-done` to signal the pause.