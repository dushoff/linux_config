#!/bin/bash
# See also scr/basewin.sh under development
(spin.sh $1.findspace 2>&1 && tmux select-window -t "$1:vim" && tmux send-keys -t "$1:vim" "gj") || ${VEDIT} ~/terminal/$1/TODO.md
