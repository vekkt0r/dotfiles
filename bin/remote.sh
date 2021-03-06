#!/bin/bash

cmd () {
    if [ "$#" -ne 2 ]; then
        repeat=1
    else
        repeat=$2
    fi
    unset IFS
    for i in $(seq "$repeat"); do
        keysender $STBIP -k $1 > /dev/null
        sleep 0.4
    done
}

keyboard() {
    echo -n "Enter text: "
    read text
    unset IFS
    commands=$(python ~/script/keyboard.py "$text" $1)
    for cmd in $commands ; do
        cmd $cmd
    done
}

run_macro () {
    action=$(echo -e "loop" | fzf)
    case $action in
        "loop")
          while [ 1 ]; do
            cmd KEY_RIGHT
            cmd KEY_RIGHT
            cmd KEY_OK
            sleep 130
          done 
          ;;
        *)
            echo "Unknown command $action" ;;
    esac
}

echo "Using STB $STBIP"

IFS=

while [ "$REPLY" != "Q" ]; do
    stty -echo
    read -d'' -s -n1
    stty echo
    cmd=""
    case $REPLY in
        "h")
            cmd="KEY_LEFT" ;;
        "l")
            cmd="KEY_RIGHT" ;;
        "J")
            cmd="KEY_CHANNEL_DOWN" ;;
        "K")
            cmd="KEY_CHANNEL_UP" ;;
        "j")
            cmd="KEY_DOWN" ;;
        "k")
            cmd="KEY_UP" ;;
        "H")
            cmd="KEY_REWIND" ;;
        "L")
            cmd="KEY_FORWARD" ;;
        "q")
            cmd="KEY_BACK" ;;
        "m")
            cmd="KEY_MENU" ;;
        "p")
            cmd="KEY_PORTAL" ;;
        " ")
            cmd="KEY_OK" ;;
        $'\n')
            cmd="KEY_OK" ;;
        "y")
            cmd="KEY_YELLOW" ;;
        "s")
            cmd="KEY_S" ;;
        "g")
            cmd="KEY_GREEN" ;;
        "r")
            cmd="KEY_RED" ;;
        "b")
            cmd="KEY_BLUE" ;;
        "t")
            cmd="KEY_TV" ;;
        "p")
            cmd="KEY_HOME" ;;
        "0")
            cmd="KEY_0" ;;
        "1")
            cmd="KEY_1" ;;
        "2")
            cmd="KEY_2" ;;
        "3")
            cmd="KEY_3" ;;
        "4")
            cmd="KEY_4" ;;
        "5")
            cmd="KEY_5" ;;
        "6")
            cmd="KEY_6" ;;
        "7")
            cmd="KEY_7" ;;
        "8")
            cmd="KEY_8" ;;
        "9")
            cmd="KEY_9" ;;
        "c")
            continue ;;
        "x")
            run_macro
            continue ;;
        *)
            echo "Unknown key: '$REPLY'" ; continue ;;
    esac
    keysender $STBIP -k $cmd > /dev/null
done
