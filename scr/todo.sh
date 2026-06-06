#!/bin/bash
spin.sh $1.findspace 2>&1 || ${VEDIT} ~/terminal/$1/TODO.md
