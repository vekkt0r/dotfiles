bindkey -M menuselect '/' accept-and-infer-next-history \
                      '^U' undo \
                      '^@' accept-and-menu-complete \
                      '^A' .beginning-of-line-hist \
                      '^E' .end-of-line-hist \
                      '^P' up-line-or-history \
                      '^N' down-line-or-history \
                      '\e<' beginning-of-history \
                      '\e>' end-of-history
