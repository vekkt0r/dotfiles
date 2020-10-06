#!/bin/bash

lines=$(xclip -o -selection clipboard)
for l in ${lines} ; do
    t=$(echo $l | sed 's/,/\./' | awk '{printf "%.1f", $1 + 0.01}' | tr -d '\n')
    xdotool type "${t}+"
    xdotool key --clearmodifiers "Tab"
done
