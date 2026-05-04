#!/bin/bash
tmpfile=$(mktemp /tmp/dictate-XXXXXX.wav)
whisper=~/screens/tech/linux_setup/whisper.cpp/
plan=~/screens/org/Planning/
sox -d -r 16000 -c 1 "$tmpfile"
text=$($whisper/build/bin/whisper-cli \
	-m $whisper/models/ggml-small.en.bin \
	-f "$tmpfile" --no-timestamps 2>/dev/null)

screen -S org -p Planning -X stuff $'\e:wall\n'
echo -n "$text" | xclip -selection clipboard
printf "%s\n" "$text" >> "$plan/dictate.txt"

paplay /usr/share/sounds/freedesktop/stereo/complete.oga ##

screen -S org -p Planning -X stuff $'\e:e\n'
