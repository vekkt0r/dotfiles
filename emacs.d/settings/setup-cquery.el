(require 'cquery)

;; Hooks
(add-hook 'c-mode-hook 'lsp-cquery-enable)
(add-hook 'c++-mode-hook 'lsp-cquery-enable)

;; Configuration
(setq cquery-executable "/home/adeng/.local/stow/cquery/bin/cquery")


(provide 'setup-cquery)
