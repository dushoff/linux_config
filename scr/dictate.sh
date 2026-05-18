#!/bin/bash
whisper=~/terminal/dirs/setup/whisper.cpp/
## ~/dictate.txt
plan=~/
segment_secs=12
tmpfile=""
fill=""
text=""
acc=""
nl=$'\n\n'

## This is only called from i3 bindings file
## It used to actively dump content into the open file in Planning, as well as cache it into dictate and keep the last line in clipboard. Some thought could be applied.
## Should have a hotkey to kill it permanently, right now it needs to time out
## Should do that and make segment_secs long

## screen -S org -p Planning -X stuff $'\e:wall\n'

process_segment() {
	text=$($whisper/build/bin/whisper-cli \
		-m $whisper/models/ggml-small.en.bin \
		-f "$tmpfile" --no-timestamps 2>/dev/null)
	rm -f "$tmpfile"
	text=$(printf '%s' "$text" | tr -d '\n' | sed '
		s/^[[:space:]]*//
		s/[[:space:]]*$//m
		s/([^)]*)//g
		s/\[[^]]*\]//g
		s/[^?.]$/&./
	')
}

listen()
{
	interrupted=0; fill=""
	tmpfile=$(mktemp /tmp/dictate-XXXXXX.wav)
	paplay /usr/share/sounds/freedesktop/stereo/bell.oga
	sox -d -r 16000 -c 1 "$tmpfile" trim 0 $segment_secs &
	wait $!
}

trap 'interrupted=1; fill=" "; pkill -SIGINT sox' SIGHUP
trap 'interrupted=1; fill=$nl; acc=""; pkill -SIGINT sox' SIGINT
trap 'pkill -SIGINT sox' SIGTERM

while true; do
	listen
	process_segment
	[ "$interrupted" -eq 0 ] && break
	printf "%s%s" "$text" "$fill" >> "$plan/dictate.txt"
	acc=$(printf "%s%s%s" "$acc" "$text" "$fill")
	echo $acc | xclip -selection clipboard
	paplay /usr/share/sounds/freedesktop/stereo/complete.oga
done

echo -n "$text" | xclip -selection primary
paplay /usr/share/sounds/freedesktop/stereo/complete.oga
paplay /usr/share/sounds/freedesktop/stereo/complete.oga

