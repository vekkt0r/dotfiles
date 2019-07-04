#!/bin/sh

pids=$(pidof $1)
if [ -z ${pids} ]; then
  $@
fi
