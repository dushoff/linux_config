#!/bin/bash
## wsmail.sh
## Bring Gmail into focus as a tab in the current workspace: reuse a
## Gmail window if one's already here, else reuse any other Chrome
## window here, else build a tabbed container and open Gmail filtered
## to this workspace's label (e.g. workspace "5:grad" -> label "grad").
##
## Meant to be run directly (e.g. from a keybinding after `make X.space`),
## with i3 idle -- unlike wstab.sh, this never has to fight a chain of
## other async i3-msg/make steps for "current workspace", which is what
## made google-chrome's single-instance --new-window race unreliable.

## Already have Gmail open here.
i3-msg '[class="Google-chrome" title="Gmail" workspace="__focused__"] focus' \
	| grep -q '"success":true' && exit 0

## Some other Chrome window is already here -- use it.
i3-msg '[class="Google-chrome" workspace="__focused__"] focus' \
	| grep -q '"success":true' && exit 0

## Nothing here yet: build a tabbed container and open Gmail in it.
label=$(i3-msg -t get_workspaces | jq -r '.[] | select(.focused).name' | sed 's/^[0-9]*://')
i3-msg 'open; split v; layout tabbed' >/dev/null
setsid google-chrome --new-window "https://mail.google.com/mail/u/0/#label/$label" >/dev/null 2>&1 &
