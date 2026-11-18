#!/bin/bash
## Finds class/title by looking on focused workspace first, then globally.
## The global search focuses a single window by con_id: a bare [class=... title=...] focus
## visits every match in turn, which leaves workspace back_and_forth pointing at the wrong place.
class="$1"
title="$2"

if ! i3-msg "[class=$class title=$title workspace=\"__focused__\"] focus" >/dev/null; then
	id=$(i3-msg -t get_tree | jq -r --arg c "$class" --arg t "$title" \
		'first(.. | objects | select((.window_properties.class? // "" | test($c)) and (.window_properties.title? // "" | test($t))) | .id) // empty')
	[ -n "$id" ] && i3-msg "[con_id=$id] focus" >/dev/null || exit 1
fi

i3-msg 'focus child' 2>/dev/null || true
