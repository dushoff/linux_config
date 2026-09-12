#!/bin/bash
## wstab.sh <class> <launch-cmd> [title-regex]
## Make sure a window matching <class> (and, if given, <title-regex>) is
## focused as a tab in the current workspace: reuse it if it's already
## here, pull it in if it's on another workspace, otherwise launch it and
## wait for it to appear.
class=$1
cmd=$2
title=$3

crit="class=\"$class\""
[ -n "$title" ] && crit="$crit title=\"$title\""

## Already here.
i3-msg "[$crit workspace=\"__focused__\"] focus" | grep -q '"success":true' && exit 0

## Uniquely identifiable (title given) and open elsewhere: bring it here
## instead of spawning a duplicate (chrome forwards --new-window to the
## running instance anyway, which is what caused it to land on whatever
## workspace was focused when the duplicate actually mapped).
if [ -n "$title" ] \
	&& i3-msg "[$crit] move to workspace current, focus" | grep -q '"success":true'
then
	exit 0
fi

## Launch it, then wait for it to show up and pull it here. Chrome (being
## single-instance) may map the window before or after this loop notices
## it, and on whatever workspace was focused at map time -- so we keep
## retrying the move/focus rather than assuming it lands here on its own.
setsid $cmd >/dev/null 2>&1 &
wcrit=$crit
[ -z "$title" ] && wcrit="$crit workspace=\"__focused__\""
for i in $(seq 1 50); do
	i3-msg "[$wcrit] move to workspace current, focus" | grep -q '"success":true' && exit 0
	sleep 0.1
done

echo "wstab.sh: timed out waiting for $class $title to appear" >&2
exit 1
