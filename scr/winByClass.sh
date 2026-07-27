#!/bin/bash
## Find any class from arguments, first in workspace, then globally. 

for class in "$@"; do
	if i3-msg "[class=\"$class\" workspace=\"__focused__\"] focus" >/dev/null; then
		i3-msg 'focus child' 2>/dev/null || true
		exit 0
	fi
done

for class in "$@"; do
	if i3-msg "[class=\"$class\"] focus" >/dev/null; then
		i3-msg 'focus child' 2>/dev/null || true
		exit 0
	fi
done

exit 1
