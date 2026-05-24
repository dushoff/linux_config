#!/bin/bash
## Focus on file, or else open it
wmctrl -a "$(basename "$1")" 2>/dev/null || gio open "$1"
