#!/bin/bash
# See also scr/basewin.sh under development
# If specified space exists
## go there, and select TODO in the corresponding tmux
## Do not focus the terminal; user can see where they were and then go to terminal
# else, open a VEDIT of TODO here

## Use focused workspace if no argument provided
if [ -z "$1" ]; then
	set -- "$(i3-msg -t get_workspaces | jq -r '.[] | select(.focused==true).name' | sed 's/^[0-9]*://')"
fi

base="${1%%.*}"

(spin.sh $base.findspace 2>&1 && tmux select-window -t "$base:0" && tmux send-keys -t "$base:0" Escape "gj") || (cd ~/terminal/$base/ && ${VEDIT} TODO.md)
