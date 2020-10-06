#!/usr/bin/env bash

fzf="$(command -v fzf 2>/dev/null)" || fzf="$(dirname "$0")/fzf"
[[ -x "$fzf" ]] || echo 'fzf executable not found' 1>&2

id=$RANDOM
argsf="${TMPDIR:-/tmp}/fzf-args-$id"
fifo0="${TMPDIR:-/tmp}/fzf-fifo0-$id"
fifo1="${TMPDIR:-/tmp}/fzf-fifo1-$id"
fifo2="${TMPDIR:-/tmp}/fzf-fifo2-$id"

cleanup() {
    \rm -f $argsf $fifo0 $fifo1 $fifo2

    if [ $# -gt 0 ]; then
        trap - EXIT
        exit 130
    fi
}
trap 'cleanup 1' SIGUSR1
trap 'cleanup' EXIT

mkfifo $fifo0
mkfifo $fifo1
mkfifo $fifo2

pppid=$$
echo -n "trap 'kill -SIGUSR1 -$pppid' EXIT SIGINT SIGTERM;" >$argsf

cat <<<"$fzf < $fifo0 > $fifo1; echo \$? > $fifo2" >>$argsf
cat <&0 >$fifo0 &
# # without `&`, the shell block without any information.
#tmux popup -xC -yC -wH -hH -KE -R "bash $argsf" &
tmux popup -KE -w99% -R "bash $argsf" &
# # tmux new-winodw works fine.
# tmux new-window "bash $argsf"
cat $fifo1
exit "$(cat $fifo2)"
#datas=$(cat $fifo2)
#exit "$(tmux send-key "$(cat $fifo2)")"
