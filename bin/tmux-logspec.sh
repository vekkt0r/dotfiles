#!/bin/bash

if [ -z "$1" -o -z "$2"  ];
then
    TMUX_WINDOW=$(tmux list-window | awk '/(active)/{print $(NF-1)}')
    TMPFILE=$(mktemp /tmp/.tmux-logspec.XXXX)

    ROOT_FOLDER = ""
    SUB_FOLDERS = ""
    EXCLUDE = ""

    tmux new-window -n "logspec" "cd ${ROOT_FOLDER} ; find ${SUB_FOLDERS} -name \"*.cc\" -type f -not -path ${EXCLUDE} -printf '%f\n' | sort | (uniq ; echo '-:*:') | fzf -m > $TMPFILE;$0 $TMUX_WINDOW $TMPFILE"
else
    text=$(sort $2)
    if [ ${#text} -ne 0 ]; then
        spec=""
        prefix=""
        for line in $text; do
            if [ "$line" = "-:*:" ] ; then
                prefix="${line}"
                continue
            fi
            spec="${prefix}${line} ${spec}"
        done
        tmux send-key -t $1 "logspec $spec"
    fi
    rm -f $2
fi
