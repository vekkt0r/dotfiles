if [[ `uname` != 'Linux' ]]
then
  return
fi

alias apts='apt-cache search'
alias apti='sudo apt-get install'
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
