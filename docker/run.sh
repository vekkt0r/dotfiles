#!/bin/sh

docker run --rm -e TERM=$TERM -p 2222:22 -p 60000:60000/udp -it dev /bin/zsh
