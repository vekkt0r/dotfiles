if status is-interactive
    # Commands to run in interactive sessions can go here
    starship init fish | source

    bind alt-backspace backward-kill-token
end
