#!/bin/sh
## Focus on and optionally send keys to a base window

## HERE part not tested yet.
if [ "$1" = "HERE" ]; then
	set -- "$(i3-msg -t get_workspaces | jq -r '.[] | select(.focused) | .name' | cut -d: -f2)" "${@:2}"
fi

make -C ~/terminal $1.base
tmux send-keys -t "$1:0" $2
