;; placeholder

(defun custom-persp/placeholder ()
  (interactive)
  (custom-persp "placeholder"
                (find-file "~/src/placeholder/")))

(define-key persp-mode-map (kbd "C-x p z") 'custom-persp/placeholder)

(project-specifics "src/placeholder"
  (ffip-local-patterns "*.cc" "*.hh" "*.mk"))


