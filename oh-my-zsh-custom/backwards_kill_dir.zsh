backward-kill-dir () {
    local WORDCHARS='*?_-.[]~=/&;!#$%^(){}<>/'
    zle backward-kill-word
}
zle -N backward-kill-dir
bindkey '^[^?' backward-kill-dir
