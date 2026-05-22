#!/bin/bash
cmd="$*"
current_pane=$(tmux display-message -p '#{pane_id}')
current_window=$(tmux display-message -p '#{window_id}')

# Close all other panes in this window
tmux list-panes -t "$current_window" -F '#{pane_id}' \
  | grep -v "^${current_pane}$" \
  | xargs -I{} tmux kill-pane -t {}

# Split vertically and execute
tmux split-window -h -t "$current_pane" "exec bash -c '$cmd'"

# Return focus to calling pane
tmux select-pane -t "$current_pane"
tmux resize-pane -x 70
