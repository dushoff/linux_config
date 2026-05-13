#!/bin/bash
whisper=~/screens/tech/linux_setup/whisper.cpp/
## ~/dictate.txt
plan=~/
segment_secs=15
tmpfile=""
text=""

screen -S org -p Planning -X stuff $'\e:wall\n'

process_segment() {
	text=$($whisper/build/bin/whisper-cli \
		-m $whisper/models/ggml-small.en.bin \
		-f "$tmpfile" --no-timestamps 2>/dev/null)
	rm -f "$tmpfile"
}

## Use k (SIGINT) to accumulate and K (SIGHUP
trap 'interrupted=1; pkill -SIGINT sox' SIGINT
trap 'pkill -SIGINT sox; process_segment' SIGHUP

while true; do
	interrupted=0
	tmpfile=$(mktemp /tmp/dictate-XXXXXX.wav)
	paplay /usr/share/sounds/freedesktop/stereo/bell.oga
	sox -d -r 16000 -c 1 "$tmpfile" trim 0 $segment_secs &
	wait $!
	process_segment
	[ "$interrupted" -eq 0 ] && break
	text=$(echo "$text" | sed 's/^[[:space:]]*//; s/[[:space:]]*$//; s/[^?.]$/&./; s/$/ /')
	printf "%s\n" "$text" >> "$plan/dictate.txt"
	screen -S org -p Planning -X stuff $'\e:e\n'
	paplay /usr/share/sounds/freedesktop/stereo/complete.oga
done
echo -n "$text" | xclip -selection primary
xclip -o -selection primary
paplay /usr/share/sounds/freedesktop/stereo/complete.oga
paplay /usr/share/sounds/freedesktop/stereo/complete.oga

