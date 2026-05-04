#!/bin/bash
whisper=~/screens/tech/linux_setup/whisper.cpp/
plan=~/screens/org/Planning/
segment_secs=4

accumulated=""
tmpfile=""

screen -S org -p Planning -X stuff $'\e:wall\n'

process_segment() {
    [ -f "$tmpfile" ] || return
    local text
    text=$($whisper/build/bin/whisper-cli \
        -m $whisper/models/ggml-small.en.bin \
        -f "$tmpfile" --no-timestamps 2>/dev/null)
    rm -f "$tmpfile"
    [ -z "$text" ] && return
    accumulated="${accumulated}${text} "
    echo -n "$accumulated" | xclip -selection clipboard
    printf "%s\n" "$text" >> "$plan/dictate.txt"
}

cleanup() {
    pkill -SIGINT sox
    while pgrep sox > /dev/null; do sleep 0.05; done
    process_segment
    exit 0
}
trap cleanup SIGINT SIGTERM

while true; do
    tmpfile=$(mktemp /tmp/dictate-XXXXXX.wav)
    paplay /usr/share/sounds/freedesktop/stereo/bell.oga ##
    sox -d -r 16000 -c 1 "$tmpfile" trim 0 $segment_secs &
    wait $!
    process_segment
    screen -S org -p Planning -X stuff $'\e:e\n'
    paplay /usr/share/sounds/freedesktop/stereo/complete.oga
done
