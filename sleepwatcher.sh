#!/bin/bash

CEC_CLIENT=/usr/local/bin/cec-client

case `basename $0` in
  .displaysleep)
    echo "off $(date)" >> /tmp/display_on.txt
    curl http://192.168.0.161/win\&T\=0
    echo "standby 0" | $CEC_CLIENT -s
    ;;
  .displaywakeup)
    echo "on $(date)" >> /tmp/display_on.txt
    curl http://192.168.0.161/win\&T\=1
    #echo "on 0" | $CEC_CLIENT -s ; sleep 5 ; echo "as" | $CEC_CLIENT -s
    ;;
esac
