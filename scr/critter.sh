#!/bin/bash
## critter name image seconds [text…]
## Log "name seconds text: HH:MM" to the report, wait, then raise a critical
## notification and the image, and log "name done: HH:MM".
## Starting a critter cancels any pending one; leave runs `pkill -x critter` (nocritter) too.

[ $# -ge 3 ] || { echo "usage: critter name image seconds [text…]" >&2; exit 1; }
name=$1; image=$2; secs=$3; shift 3

## nocritter, sparing ourselves: a new critter replaces any pending one
pgrep -x critter | grep -vx $$ | xargs -r kill
label="$name $secs${*:+ $*}"

## Same as vsave + reporttime in .baliases (functions/aliases aren't visible here)
reporttime() {
	for instance in $(vim --serverlist); do
		vim --servername $instance --remote-send $'\e:wa\n'
	done
	echo "$1: $(date +%H:%M)" >> "${report:-$HOME/terminal/dirs/Planning/report.md}"
}

reporttime "$label"
set=$(date +%H:%M)
sleep "$secs"
notify-send -u critical "$label" "set at $set"
feh -F --auto-zoom --start-at "$image" &
reporttime "$name done"
