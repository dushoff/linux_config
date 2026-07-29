#!/bin/bash
## Finds class/title by looking on focused workspace first
class="$1"
title="$2"

i3-msg "[class=$class title=$title workspace=\"__focused__\"] focus" || i3-msg "[class=$class title=$title] focus"

i3-msg 'focus child' 2>/dev/null || true

