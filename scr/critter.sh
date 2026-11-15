#!/bin/bash
## critter.sh NAME PICTURE SECONDS [text…]
## Log "NAME SECONDS text: HH:MM" to the report, wait, then log "NAME done: HH:MM",
## raise a persistent notification and show the picture.
## Killing it while it waits (pkill -x critter.sh; see nocritter/leave) means no picture and no "done".

set -u

usage() { echo "usage: critter.sh NAME PICTURE SECONDS [text…]" >&2; exit 1; }
[ $# -ge 3 ] || usage
name=$1; picture=$2; secs=$3; shift 3
[[ $secs =~ ^[0-9]+$ ]] || usage
text="$*"
: "${report:?report is not set}"

## Save open vim buffers first, so a buffer showing the report doesn't clobber our line
vsave() {
	for instance in $(vim --serverlist 2>/dev/null); do
		vim --servername "$instance" --remote-send $'\e:wa\n'
	done
}

logline() { vsave; echo "$1: $(date +%H:%M)" >> "$report"; }

logline "$name $secs${text:+ $text}"
set=$(date +%H:%M)

## Sleep in the background so a TERM from pkill kills the sleep too
trap 'kill $sleeper 2>/dev/null; exit 0' TERM INT HUP
sleep "$secs" & sleeper=$!
wait $sleeper

logline "$name done"
notify-send -u critical "$name $secs${text:+ $text}" "set at $set"
exec feh -F --auto-zoom --start-at "$picture"  ## exec: nocritter won't close a picture already up
