#!/bin/bash
## i3-msg focus parent; focus parent
i3-msg "[class=\"$1\" workspace=\"__focused__\"] focus" || (i3-msg open && i3-msg 'split v; layout tabbed' && exec $2)
i3-msg 'focus child'
