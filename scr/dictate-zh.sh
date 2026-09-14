#!/bin/bash
whisper=~/terminal/dirs/setup/whisper.cpp/
opencc_py=~/.venvs/dictate-zh/bin/python3
## ~/dictate-zh.txt ~/dbuff-zh.txt
store=~/
segment_secs=30
tmpfile=""
fill=""
text=""
acc=""
nl=$'\n\n'
sep="$nl$(printf -- '-%.0s' {1..70})$nl"
halt=0

## Convert audio file into a text chunk (global variable)
process_segment() {
	text=$($whisper/build/bin/whisper-cli \
		-m $whisper/models/ggml-medium.bin \
		-l zh \
		-f "$tmpfile" --no-timestamps 2>/dev/null)
	rm -f "$tmpfile"
	text=$(printf '%s' "$text" | tr -d '\n' | sed '
		s/^[[:space:]]*//
		s/[[:space:]]*$//m
		s/([^)]*)//g
		s/\[[^]]*\]//g
	')
	text=$("$opencc_py" -c "
import sys, opencc
c = opencc.OpenCC('s2twp')
sys.stdout.write(c.convert(sys.stdin.read()))
" <<< "$text")
	paplay /usr/share/sounds/freedesktop/stereo/complete.oga
}

## Listen until time is up or until interrupted
listen()
{
	interrupted=0; fill=""
	tmpfile=$(mktemp /tmp/dictate-zh-XXXXXX.wav)
	paplay /usr/share/sounds/freedesktop/stereo/bell.oga
	sox -d -r 16000 -c 1 "$tmpfile" trim 0 $segment_secs &
	wait $!
}

trap 'interrupted=1; fill=" "; pkill -SIGINT sox' SIGHUP
trap 'interrupted=1; fill=$nl; pkill -SIGINT sox' SIGINT
trap 'interrupted=1; fill=$nl; halt=1; pkill -SIGINT sox' SIGTERM

while true; do
	listen
	[ "$interrupted" -eq 0 ] && break
	process_segment
	printf "%s%s" "$text" "$fill" >> "$store/dictate-zh.txt"
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
printf "%s%s" "$text" "$fill" > "$store/dbuff-zh.txt"
	paplay /usr/share/sounds/freedesktop/stereo/complete.oga
