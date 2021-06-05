alias agc='ag -G "\.cpp$"'
alias c='cd ..'
alias ec='emacsclient -n'
alias kb='bg && kill $! && fg'
alias ltr='ls -ltr'
alias cf='c++filt'
alias reboot='echo nope'
alias tb='tmux set-buffer'
alias tgf='tig --first-parent'
alias tgs='tig status'
alias fd='fd --glob'
alias gh='git rev-parse HEAD'
alias ds="docker exec -it \$(docker ps -l | tail -n1 | awk '{print \$NF}') /bin/bash"
alias tmux_set_pane_name="tmux set pane-border-status top && printf '\033]2;%s\033\\'"

# Global alias
alias -g F='find . -name'
alias -g G='| grep'
alias -g NF='*(oc[1])'
alias -g NF1='*(om[2])'
alias -g CF='| c++filt'
alias -g XG='| xargs grep'

# Suffix alias
alias -s {c,h,cpp,log,txt,json}=bat
alias -s {html}=w3m

# Functions
gapp() {
  git diff -U0 | grepdiff --output-matching=hunk -E $1 | git apply --cached --unidiff-zero
}

# Git commit with current rebase-amend message
gcr() {
  local top=$(git rev-parse --show-toplevel)/.git
  [ -f $top ] && top=$(awk '{print $2}' ${top})
  git commit -c `cat ${top}/rebase-merge/amend`
}

# Git add file via fzf helper
gaf() {
  git status -s | awk '$1 ~ /[MADR]/ { print $2 }' | fzf -m | xargs git add
}
