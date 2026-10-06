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

# Optional arguments replace --auto (e.g. mirror.sh --mode 1920x1080)
if [ $# -eq 0 ]; then
	set -- --auto
fi

xrandr --output "$SECOND" --same-as "$INTERNAL" "$@"
