#!/bin/bash
# See also scr/basewin.sh under development
# If specified space exists, go there, and select TODO in the corresponding tmux
## Do not focus the terminal; user can see where they were and then go to terminal
# else, open a VEDIT of TODO here

base="${1%%.*}"

(spin.sh $base.findspace 2>&1 && tmux select-window -t "$base:vim" && tmux send-keys -t "$base:vim" "gj") || (cd ~/terminal/$base/ && ${VEDIT} TODO.md)
