MAIN="eDP-1"
OTHERS=$(xrandr --query | grep " connected" | grep -v "^$MAIN" | cut -d' ' -f1)
CMD="xrandr --output $MAIN --auto"
for o in $OTHERS; do CMD="$CMD --output $o --off"; done
eval "$CMD"
