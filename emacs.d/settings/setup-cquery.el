(require 'cquery)

;; Hooks
(add-hook 'c-mode-hook 'lsp-cquery-enable)
(add-hook 'c++-mode-hook 'lsp-cquery-enable)

;; Configuration
(setq cquery-executable "/home/adeng/.local/stow/cquery/bin/cquery")
(setq cquery-index-blacklist '(".*/placeholder/build.*" ".*/placeholder/3pp/.*"))
(setq cquery-additional-arguments '("--log-file /tmp/cquery.log"))
(setq cquery-indexer-count '50)

(provide 'setup-cquery)
