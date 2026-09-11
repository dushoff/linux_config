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

xrandr --output "$SECOND" --same-as "$INTERNAL" --auto
