#!/bin/bash
## i3status wrapper: append a bright CAPS block when Caps Lock is on.
## i3.config refreshes it instantly via a Caps_Lock release binding (SIGUSR1).

conf=${1:-~/terminal/dirs/config/i3status.conf}
caps='{"name":"caps","full_text":" CAPS ","color":"#000000","background":"#ffff00","border":"#ff0000"}'

i3status -c "$conf" | {
	read -r line && echo "$line"   # {"version":1}
	read -r line && echo "$line"   # [
	while read -r line; do
		if xset q | grep -q 'Caps Lock: *on'; then
			line="${line%]},$caps]"
		fi
		echo "$line"
	done
}
