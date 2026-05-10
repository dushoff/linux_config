#!/bin/sh
## usage exec topscreen subscreen exectext

## Should redo this script to not depend on rwindow (or redo rwindow to be more general)
if echo "$1" | grep -q '/'; then
    set -- $(echo "$1" | tr '/' ' ') "$2"
fi

make -C ~/terminal $1/$2.rwindow.view
tmux send-keys -t "$1:$2" "$3"
