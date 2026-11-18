#!/bin/bash
## Find any class from arguments, first in workspace, then globally.
## The global search focuses a single window by con_id: a bare [class=...] focus visits
## every match in turn, which leaves workspace back_and_forth pointing at the wrong place.

for class in "$@"; do
	if i3-msg "[class=\"$class\" workspace=\"__focused__\"] focus" >/dev/null; then
		i3-msg 'focus child' 2>/dev/null || true
		exit 0
	fi
done

tree=$(i3-msg -t get_tree)
for class in "$@"; do
	id=$(jq -r --arg c "$class" \
		'first(.. | objects | select(.window_properties.class? // "" | test($c)) | .id) // empty' <<< "$tree")
	if [ -n "$id" ] && i3-msg "[con_id=$id] focus" >/dev/null; then
		i3-msg 'focus child' 2>/dev/null || true
		exit 0
	fi
done

exit 1
