#!/bin/sh
## Select tmux window $1 in the session named after the focused workspace
## (workspace "1:tech" → session "tech"). Called from i3 Ctrl+[0-9].
ws=$(i3-msg -t get_workspaces | jq -r '.[] | select(.focused) | .name')
tmux select-window -t "${ws#*:}:$1"
