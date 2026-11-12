#!/bin/bash
set -euo pipefail

# screens.sh laptop|external|mirror|extend [xrandr args for mirror | output for extend]
# Each mode quietly does nothing if the needed displays aren't present,
# so the same i3 bindings are safe on a desktop or an undocked laptop.

usage() { echo "usage: $0 laptop|external|mirror|extend [args]" >&2; exit 2; }
[ $# -ge 1 ] || usage
MODE=$1; shift

# Connected outputs; the laptop panel is recognized by name
CONNECTED=$(xrandr -q | awk '/ connected/ {print $1}')
INTERNAL=$(grep -E -m1 '^(eDP|LVDS|DSI)' <<<"$CONNECTED" || true)
EXTERNAL=$(grep -v -x -F "${INTERNAL:-NONE}" <<<"$CONNECTED" | head -n1 || true)

skip() { echo "screens.sh $MODE: $1; nothing to do" >&2; exit 0; }

case $MODE in
laptop)
	# Panel only; also the recovery key after undocking with the panel off
	[ -n "$INTERNAL" ] || skip "no laptop panel"
	OTHERS=$(xrandr -q | awk -v internal="$INTERNAL" '
		/^[^ ]+ (dis)?connected/ && $1 != internal {
			printf " --output %s --off", $1
		}
	')
	# $OTHERS is deliberately unquoted so it splits into arguments
	xrandr --output "$INTERNAL" --auto --primary --transform none $OTHERS
	;;
external)
	# External only; i3 moves workspaces off the disabled panel
	[ -n "$INTERNAL" ] || skip "no laptop panel"
	[ -n "$EXTERNAL" ] || skip "no external display"
	xrandr --output "$EXTERNAL" --auto --primary --transform none \
		--output "$INTERNAL" --off
	;;
mirror)
	[ -n "$INTERNAL" ] || skip "no laptop panel"
	[ -n "$EXTERNAL" ] || skip "no external display"
	# Optional arguments replace the default (e.g. --mode 1920x1080)
	# --transform none clears scaling left over from --scale-from or --transform
	[ $# -gt 0 ] || set -- --auto --transform none
	xrandr --output "$INTERNAL" --auto --primary \
		--output "$EXTERNAL" --same-as "$INTERNAL" "$@"
	;;
extend)
	# Panel plus external side by side; external is primary.
	# Optional argument names the output (e.g. HDMI-1); default is first found.
	# i3 leaves existing workspaces where they are and opens a new one there.
	[ -n "$INTERNAL" ] || skip "no laptop panel"
	if [ $# -gt 0 ]; then
		grep -q -x -F "$1" <<<"$CONNECTED" || skip "$1 not connected"
		EXTERNAL=$1
	fi
	[ -n "$EXTERNAL" ] || skip "no external display"
	xrandr --output "$INTERNAL" --auto --transform none \
		--output "$EXTERNAL" --auto --primary --transform none \
		--right-of "$INTERNAL"
	;;
*) usage ;;
esac
