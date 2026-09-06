#!/bin/bash
# See also scr/basewin.sh under development
base="${1%%.*}"
(spin.sh $base.findspace 2>&1 && tmux select-window -t "$base:vim" && tmux send-keys -t "$base:vim" "gj") || (cd ~/terminal/$base/ && ${VEDIT} TODO.md)
