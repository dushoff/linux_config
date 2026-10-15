#!/bin/sh
## usage (from i3) exec $scr/i3bash.sh command
## Run a .baliases command; notify if bash reports a problem (otherwise errors vanish into i3's stderr)

bad='syntax error\|command not found\|unexpected end of file'
log=$(mktemp)
bash -ic "$*" 2>"$log"
status=$?
if grep -q "$bad" "$log"; then
	notify-send -u critical "i3bash: $*" "$(grep "$bad" "$log")"
fi
rm -f "$log"
exit $status
