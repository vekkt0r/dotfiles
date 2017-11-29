;; whitespace-mode config
(require 'whitespace)
(setq whitespace-line-column 80) ;; limit line length
(setq whitespace-style '(face tabs empty trailing lines-tail))

;; setup hooks
(defun my-setup-enable-whitespace ()
  "Enable `whitespace-mod'"
  (add-hook 'before-save-hook 'whitespace-cleanup)
  (whitespace-mode +1))

(add-hook 'text-mode-hook 'my-setup-enable-whitespace)
(add-hook 'c-mode-common-hook 'my-setup-enable-whitespace)

(provide 'setup-whitespace)
