#!/bin/bash

if [ "$#" -ne 1 ]; then
  echo "Usage: $0 <user@host>"
  exit
fi

ssh $1 "apt update; apt install transmission-daemon transmission-remote"
scp bin/torque $1:
scp transmission.json $1:/etc/transmission-daemon/settings.json
