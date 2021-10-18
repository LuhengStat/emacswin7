
(elpy-enable)
(setq elpy-project-root nil)
(setq elpy-shell-use-project-root nil)

(add-hook 'elpy-mode-hook (lambda () (highlight-indentation-mode -1)))
;; (when (load "flycheck" t t)
;;   (setq elpy-modules (delq 'elpy-module-flymake elpy-modules)))

(add-hook 'elpy-mode-hook (lambda () (highlight-indentation-mode -1)))
(add-hook 'inferior-python-mode-hook 'visual-line-mode)
(setq elpy-modules (delq 'elpy-module-flymake elpy-modules))

(defun mydef-RET ()
  "define RET behavior in python"
  (interactive)
  (setq current-line (what-line))
  (end-of-buffer)
  (if (string=  current-line (what-line))
      (comint-send-input)))
(define-key inferior-python-mode-map (kbd "RET") 'mydef-RET)

(defun elpy-goto-definition-or-rgrep ()
  "Go to the definition of the symbol at point, if found. Otherwise, run `elpy-rgrep-symbol'."
    (interactive)
    (ring-insert find-tag-marker-ring (point-marker))
    (condition-case nil (elpy-goto-definition)
        (error (elpy-rgrep-symbol
                   (concat "\\(def\\|class\\)\s" (thing-at-point 'symbol) "(")))))

(define-key elpy-mode-map (kbd "C-c C-c") 'elpy-shell-send-group-and-step)
(define-key elpy-mode-map (kbd "C-c C-l") 'elpy-shell-send-buffer-and-step)
(define-key elpy-mode-map (kbd "C-c C-s") 'counsel-projectile-rg)
(define-key elpy-mode-map (kbd "C-.") 'xref-find-definitions-other-window)
(define-key elpy-mode-map (kbd "M-.") 'elpy-goto-assignment)


(defun mydef-eval-line ()
  "eval line and step"
  (interactive)
  (setq current-line (what-line))
  (elpy-shell-send-statement-and-step)
  (if (string=  current-line (what-line))
      (progn
	(end-of-line)
	(newline))))
(define-key elpy-mode-map (kbd "<C-return>") 'mydef-eval-line)

(define-key elpy-mode-map (kbd "s-r") 'elpy-shell-send-region-or-buffer)

(setq python-shell-prompt-detect-failure-warning nil)
(setq python-shell-completion-native-enable nil) 

(setq python-shell-interpreter "jupyter"
      python-shell-interpreter-args "console --simple-prompt"
      python-shell-prompt-detect-failure-warning nil)
(add-to-list 'python-shell-completion-native-disabled-interpreters
             "jupyter")

;;(setq python-check-command (expand-file-name "~/.local/bin/flake8"))


(provide 'init-python)


