#!/bin/bash
set -euo pipefail

## Switch audio to the built-in analog card (it disappears when the card
## gets put in HDMI mode), then pick the port
## Usage: analogOut.sh <sink> <port>   (e.g., $sink $speaker from i3.local.conf)

SINK="$1"
PORT="$2"
CARD=$(echo "$SINK" | sed -E 's/^alsa_output\.(.*)\.analog-stereo$/alsa_card.\1/')

pactl set-card-profile "$CARD" output:analog-stereo+input:analog-stereo
pactl set-default-sink "$SINK"
pactl set-sink-port "$SINK" "$PORT"
