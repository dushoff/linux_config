#!/bin/bash
wmctrl -a "$(basename "$1")" 2>/dev/null || gio open "$1"
