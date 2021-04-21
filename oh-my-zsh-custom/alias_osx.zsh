if [[ `uname` != 'Darwin' ]]
then
  return
fi

alias ec="/Applications/Emacs.app/Contents/MacOS/bin/emacsclient -n"
alias lsusb="system_profiler SPUSBDataType"

export LC_ALL=en_US.UTF-8
