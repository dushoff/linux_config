#!/bin/bash
## Focus on an rwindow inside a space, making it if necessary, and send keys to it if requested

## Should redo this script to not depend on rwindow (or redo rwindow to be more general)
if echo "$1" | grep -q '/'; then
	set -- $(echo "$1" | tr '/' ' ') "$2"
fi

get_focused_workspace() {
	i3-msg -t get_workspaces | jq -r '.[] | select(.focused==true).name'
}

ws="$1"
if [[ "$ws" == "." ]]; then
	ws="$(get_focused_workspace | sed 's/^[0-9]*://')"
fi

echo $ws > ~/make.log

make -C ~/terminal $ws/$2.rwindow.view
tmux send-keys -t "$ws:$2" "$3"
