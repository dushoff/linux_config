#!/bin/bash
tmpfile=$(mktemp /tmp/dictate-XXXXXX.wav)
whisper=~/screens/tech/linux_setup/whisper.cpp/
plan=~/screens/org/Planning/
sox -d -r 16000 -c 1 "$tmpfile"
text=$($whisper/build/bin/whisper-cli \
	-m $whisper/models/ggml-small.en.bin \
	-f "$tmpfile" --no-timestamps 2>/dev/null)
echo -n "$text" | xclip -selection clipboard
echo -n "$text" >> $plan/dump.md
paplay /usr/share/sounds/freedesktop/stereo/complete.oga ##
