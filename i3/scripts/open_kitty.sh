#!/usr/bin/env bash

# Find required commands via PATH
xdotool=$(command -v xdotool)
kitty=$(command -v kitty)

# Abort if required commands are missing
if [[ -z "$xdotool" || -z "$kitty" ]]; then
  notify-send "Missing dependencies" "xdotool or kitty not found in PATH"
  exit 1
fi

# Get the currently focused window and its PID
focused_win_id=$("$xdotool" getwindowfocus)
focused_pid=$("$xdotool" getwindowpid "$focused_win_id")

# Resolve the working directory
cwd=$(readlink "/proc/$focused_pid/cwd")
[ -d "$cwd" ] || cwd="$HOME"

# Launch kitty in the resolved directory
exec "$kitty" --directory "$cwd"

