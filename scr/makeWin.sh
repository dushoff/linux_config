#!/bin/bash
class="$1"
title="$2"
shift 2
i3-msg "[class=$class title=$title] focus" || "$@"
