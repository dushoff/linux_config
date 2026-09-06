#!/bin/bash
# See also scr/basewin.sh under development
base="${1%%.*}"
(spin.sh $1.findspace 2>&1 && tmux select-window -t "$base:vim" && tmux send-keys -t "$base:vim" "gj") || ${VEDIT} ~/terminal/$base/TODO.md
