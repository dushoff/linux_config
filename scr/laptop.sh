#!/bin/bash
set -euo pipefail

# Laptop panel only; also the recovery key after undocking with the panel off
INTERNAL="eDP-1"

OTHERS=$(xrandr -q | awk -v internal="$INTERNAL" '
	/^[^ ]+ (dis)?connected/ && $1 != internal {
		printf " --output %s --off", $1
	}
')

# $OTHERS is deliberately unquoted so it splits into arguments
xrandr --output "$INTERNAL" --auto --primary --transform none $OTHERS
