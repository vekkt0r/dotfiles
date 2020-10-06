#!/bin/sh

if [ "nx-aengstrom" = $(hostname) ]; then
  $@
else
  ssh 192.168.47.228 "DISPLAY=:0 $@"
fi
