#!/bin/bash
whisper=~/terminal/dirs/setup/whisper.cpp/
## ~/dictate.txt ~/dbuff.txt
store=~/
segment_secs=30
tmpfile=""
fill=""
text=""
acc=""
nl=$'\n\n'
sep="$nl$(printf -- '-%.0s' {1..70})$nl"
halt=0

## screen -S org -p Planning -X stuff $'\e:wall\n'

## Convert audio file into a text chunk (global variable)
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
	paplay /usr/share/sounds/freedesktop/stereo/complete.oga
}

## Listen until time is up or until interrupted
listen()
{
	interrupted=0; fill=""
	tmpfile=$(mktemp /tmp/dictate-XXXXXX.wav)
	paplay /usr/share/sounds/freedesktop/stereo/bell.oga
	sox -d -r 16000 -c 1 "$tmpfile" trim 0 $segment_secs &
	wait $!
}

## fill=$sep to separate dictation sessions, not currently in place? Problem is that we don't want a separator if we're only doing one session at a time.
## If separators are wanted, consider: putting them first, not sending them to clipboard, trimming the first one on read.
trap 'interrupted=1; fill=" "; pkill -SIGINT sox' SIGHUP
trap 'interrupted=1; fill=$nl; pkill -SIGINT sox' SIGINT
trap 'interrupted=1; fill=$nl; halt=1; pkill -SIGINT sox' SIGTERM

while true; do
	listen
	[ "$interrupted" -eq 0 ] && break
	process_segment
	printf "%s%s" "$text" "$fill" >> "$store/dictate.txt"
	printf -v acc "%s%s%s" "$acc" "$text" "$fill"
	printf "%s" "$acc" | xclip -selection clipboard
	if [ "$halt" -eq 1 ]; then
		paplay /usr/share/sounds/freedesktop/stereo/complete.oga
		exit
	fi
done

paplay /usr/share/sounds/freedesktop/stereo/service-logout.oga
process_segment
echo -n "$text" | xclip -selection primary
printf "%s%s" "$text" "$fill" > "$store/dbuff.txt"
	paplay /usr/share/sounds/freedesktop/stereo/complete.oga

