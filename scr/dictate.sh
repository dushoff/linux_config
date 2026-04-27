#!/bin/bash
TMPFILE=$(mktemp /tmp/dictate-XXXXXX.wav)
sox -d -r 16000 -c 1 "$TMPFILE"
TEXT=$(~/screens/tech/linux_setup/whisper.cpp/build/bin/whisper-cli \
	-m ~/screens/tech/linux_setup/whisper.cpp/models/ggml-small.en.bin \
	-f "$TMPFILE" --no-timestamps 2>/dev/null)
echo -n "$TEXT" | xclip -selection clipboard
