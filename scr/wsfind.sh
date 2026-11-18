#!/bin/bash

## Focus a window of class $1: prefer the focused workspace, else the first match anywhere.
## Don't use a bare [class=...] focus as the fallback: with several matches i3 visits each
## in turn, which leaves workspace back_and_forth pointing at the wrong place.
i3-msg "[class=\"$1\" workspace=\"__focused__\"] focus" > /dev/null && exit
id=$(i3-msg -t get_tree | jq -r --arg c "$1" \
  'first(.. | objects | select(.window_properties.class? == $c) | .id) // empty')
[ -n "$id" ] && i3-msg "[con_id=$id] focus"
