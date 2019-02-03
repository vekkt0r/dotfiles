;; Pull from PRIMARY (same as middle mouse click)
(defun paste-primary-selection ()
  (interactive)
  (insert
   (x-get-selection 'PRIMARY)))
(global-set-key (kbd "s-<insert>") 'paste-primary-selection)
(provide 'paste-primary)
