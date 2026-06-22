#!/bin/bash
SECOND=$(xrandr | grep ' connected' | sed -n '2p' | cut -d' ' -f1)
if [ -n "$SECOND" ]; then
    xrandr --output "$SECOND" --same-as eDP-1 --auto
fi
