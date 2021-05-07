#!/bin/bash

if [ -z "$1" -o -z "$2"  ];
then
    TMUX_WINDOW=$(tmux list-window | awk '/(active)/{print $(NF-1)}')
    TMPFILE=$(mktemp /tmp/.tmux-snippets.XXXX)

    if [[ -n $(tmux list-commands popup) ]]; then
      tmux popup -E -w 100% "grep -Ev '^(#|$)' $HOME/.snippets | fzf > $TMPFILE;$0 $TMUX_WINDOW $TMPFILE"
    else
      tmux new-window -n "snippets" "grep -Ev '^(#|$)' $HOME/.snippets | fzf > $TMPFILE;$0 $TMUX_WINDOW $TMPFILE"
    fi
else
    tmux send-key -t $1 "$(cat $2)"
    rm -f $2
fi
