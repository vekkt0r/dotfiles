#!/bin/sh

if [ "jump_host" = $(hostname) ]; then
  $@
else
  ssh 192.168.47.228 "DISPLAY=:0 $@"
fi
