#!/bin/bash

curl -s http://api.temperatur.nu/tnu_1.12.php\?p\=valla\&verbose\&cli\=${RANDOM} | grep "<temp>" | sed 's/.*temp>\(.*\)<\/temp>/\1°/'
