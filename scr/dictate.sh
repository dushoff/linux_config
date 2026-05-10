#!/bin/bash
whisper=~/screens/tech/linux_setup/whisper.cpp/
loc=~/
segment_secs=15
accumulated=""
tmpfile=""

## screen -S org -p Planning -X stuff $'\e:wall\n'

process_segment() {
	local text
	text=$($whisper/build/bin/whisper-cli \
		-m $whisper/models/ggml-small.en.bin \
		-f "$tmpfile" --no-timestamps 2>/dev/null)
	rm -f "$tmpfile"
	[ -z "$text" ] && return
	accumulated="${accumulated}${text} "
	echo -n "$accumulated" | xclip -selection clipboard
	printf "%s\n" "$text" >> "$loc/dictate.txt"
	## screen -S org -p Planning -X stuff $'\e:e\n'
	paplay /usr/share/sounds/freedesktop/stereo/complete.oga
}

trap 'interrupted=1; pkill -SIGINT sox' SIGINT
trap 'pkill -SIGINT sox; process_segment' SIGHUP

while true; do
	interrupted=0
	tmpfile=$(mktemp /tmp/dictate-XXXXXX.wav)
	paplay /usr/share/sounds/freedesktop/stereo/bell.oga
	sox -d -r 16000 -c 1 "$tmpfile" trim 0 $segment_secs &
	wait $!
	[ "$interrupted" -eq 0 ] && break
	process_segment
done
paplay /usr/share/sounds/freedesktop/stereo/message.oga ##
