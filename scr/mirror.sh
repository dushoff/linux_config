#!/bin/bash
set -euo pipefail

INTERNAL="eDP-1"

SECOND=$(xrandr -q | awk -v internal="$INTERNAL" '
	/ connected/ && $1 != internal {
		print $1
		exit
	}
')

if [ -z "$SECOND" ]; then
	echo "No external display found" >&2
	exit 1
fi

# Optional arguments replace the default (e.g. mirror.sh --mode 1920x1080)
# --transform none clears scaling left over from --scale-from or --transform
if [ $# -eq 0 ]; then
	set -- --auto --transform none
fi

xrandr --output "$INTERNAL" --auto --primary \
	--output "$SECOND" --same-as "$INTERNAL" "$@"
