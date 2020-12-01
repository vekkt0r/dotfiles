#!/bin/bash
#
# Optional argument: directory with source file
# - will set tmux environment var and spawn new split window performing
#   make local_all
#
box="Boxname"

find_make () {
  path="$1"
  while [[ $path != / ]];
  do
    if [ -f ${path}/Makefile ]; then
      echo $path
      return
    fi
    path=$(dirname ${path})
  done
  echo $1
}


if [ "$#" -ne 0 ]; then
  path=$(find_make $1)
  tmux set-environment build_dir $path
  tmux source-file ~/bin/build.tmux
  exit
fi

if [ -z ${build_dir} ]; then
  bootimage=$(readlink -f /var/www/html/${box})
  build_dir=$(dirname ${bootimage})/../../
else
  target="local_all"
  tmux set-environment -u build_dir
fi

(cd ${build_dir} && make ${target} || less -j4 "+/error|warn|Error|FAIL" ${build_dir}/.buildlog/failed/*)
