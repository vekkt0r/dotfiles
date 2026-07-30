if status is-interactive
    # Commands to run in interactive sessions can go here
    starship init fish | source

    set -qU FZF_TMUX_HEIGHT ; or set -Ux FZF_TMUX_HEIGHT '100%'
    fzf --fish | source

    bind alt-backspace backward-kill-token
end
