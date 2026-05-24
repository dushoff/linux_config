#!/bin/bash
## i3-msg focus parent; focus parent
i3-msg "[class=\"$1\" workspace=\"__focused__\"] focus" || i3-msg "focus"
i3-msg 'focus child'
