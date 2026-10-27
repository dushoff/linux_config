#!/bin/bash
# -e: skip the 72-column resize (caller will even out the layout)
resize=1
if [ "$1" = "-e" ]; then resize=; shift; fi
cmd="$*"
current_pane=$(tmux display-message -p '#{pane_id}')
current_window=$(tmux display-message -p '#{window_id}')

# Refuse if any other pane is running something besides a disposable command
busy=$(tmux list-panes -t "$current_window" -F '#{pane_id} #{pane_current_command}' \
  | grep -v "^${current_pane} " \
  | grep -vE ' (bash|sh|zsh|watch|less|man)$')
if [ "$busy" ]; then
  tmux display-message "showpane: other pane busy ($(echo "$busy" | awk '{print $2}' | paste -sd' ')); not killing"
  exit 1
fi

# Close all other panes in this window
tmux list-panes -t "$current_window" -F '#{pane_id}' \
  | grep -v "^${current_pane}$" \
  | xargs -I{} tmux kill-pane -t {}

# Split vertically and execute
tmux split-window -h -t "$current_pane" "exec bash -c '$cmd'"

# Return focus to calling pane
tmux select-pane -t "$current_pane"
if [ "$resize" ]; then tmux resize-pane -x 72; fi
