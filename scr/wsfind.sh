#!/bin/bash

## Finds class by looking on focused workspace first; should we have a version that finds also title?
## i3-msg focus parent; focus parent
i3-msg "[class=\"$1\" workspace=\"__focused__\"] focus" || i3-msg "[class=\"$1\"] focus"

## Worry about this line; it can kick errors. So far we don't seem to care, though.
i3-msg 'focus child'
