
;; user define functions
;; (defun mydef-quick-save-flash-ideas ()
;;   "quickly save some flash ideas"
;;   (interactive)
;;   (find-file-other-window "/Users/wlh/Documents/Learning/FlashIdeas.org"))
;; (global-set-key (kbd "s-6") 'mydef-quick-save-flash-ideas)

(defun mydef-open-line-and-next ()
  "open a new line and go to the next line"
  (interactive)
  (open-line 1)
  (next-line)
  )
(global-set-key (kbd "C-j") 'mydef-open-line-and-next)
(add-hook 'bibtex-mode-hook
	  (lambda ()
	    (define-key bibtex-mode-map (kbd "C-j") 'mydef-open-line-and-next)))

(defun mydef-mark-whole-line ()
  "mark the whole line"
  (interactive)
  (call-interactively 'move-beginning-of-line)
  (call-interactively 'set-mark-command)
  (call-interactively 'move-end-of-line))
(global-set-key (kbd "C-x C-l") 'mydef-mark-whole-line)

(defun mydef-fill-paragraph ()
  "let the position being better after indented"
  (interactive)
  (fill-paragraph)
  (recenter 16))
;;(global-set-key (kbd "M-q") 'mydef-fill-paragraph)


;; easy move in read-only buffers
;; enter view-mode for read-only files
(setq view-read-only t)
(add-hook 'view-mode-hook
	  (lambda ()
	    (define-key view-mode-map (kbd "n") 'forward-paragraph)
	    (define-key view-mode-map (kbd "p") 'backward-paragraph)
	    (define-key view-mode-map (kbd "]") 'end-of-buffer)
	    (define-key view-mode-map (kbd "[") 'beginning-of-buffer)
	    (define-key view-mode-map (kbd "l") 'recenter-top-bottom)))
(add-hook 'help-mode-hook
	  (lambda ()
	    (define-key help-mode-map (kbd "n") 'forward-paragraph)
	    (define-key help-mode-map (kbd "p") 'backward-paragraph)
	    (define-key help-mode-map (kbd "]") 'end-of-buffer)
	    (define-key help-mode-map (kbd "[") 'beginning-of-buffer)
	    (define-key help-mode-map (kbd "l") 'recenter-top-bottom)))
;;(add-hook 'help-mode-hook 'turn-on-evil-mode)
;;(add-hook 'view-mode-hook 'turn-on-evil-mode)
;;(global-set-key (kbd "s-e")  'evil-mode)


;; disable some keys
(global-set-key (kbd "s-x") 'nil)
(global-set-key (kbd "C-x C-n") 'nil)
(global-set-key (kbd "C-x g") 'magit-status)

;; browser the kill ring
(global-set-key (kbd "C-c C-y") 'browse-kill-ring)
(global-set-key (kbd "C-c y") 'browse-kill-ring)
(add-hook 'org-mode-hook
	  (lambda ()
	    (define-key org-mode-map (kbd "C-c C-y") 'browse-kill-ring)
	    (define-key org-mode-map (kbd "C-c y") 'browse-kill-ring)))


;; change the window size
(global-set-key (kbd "S-C-<left>") 'shrink-window-horizontally)
(global-set-key (kbd "S-C-<right>") 'enlarge-window-horizontally)
(global-set-key (kbd "S-C-<down>") 'shrink-window)
(global-set-key (kbd "S-C-<up>") 'enlarge-window)1


;; Enable Cache, for youdao translator h
(setq url-automatic-caching t)
;; Set file path for saving search history
;;(setq youdao-dictionary-search-history-file "/Users/wlh/Documents/Learning/youdao.txt")
;; Example Key binding
;; Integrate with popwin-el (https://github.com/m2ym/popwin-el)    (left top right bottom)
;;(push '("*Youdao Dictionary*" :width 0.5 :height 0.36 :position bottom) popwin:special-display-config)
;;(push "*Youdao Dictionary*" popwin:special-display-config)

(defun mydef-youdao ()
  "If there has a youdao buffer, close it"
  (interactive)
  (if (get-buffer-window "*Youdao Dictionary*")
      (progn   (if (not (popwin:close-popup-window))
		   (previous-buffer)))
    (youdao-dictionary-search-at-point)))
(global-set-key (kbd "s-y") 'mydef-youdao)

(defun mydef-youdao-input ()
  "close the older youdao windw before input the new word"
  (interactive)
  (youdao-dictionary-search-from-input)
  (popwin:popup-last-buffer))
(add-hook 'youdao-dictionary-mode-hook
	  (lambda ()
	    (define-key youdao-dictionary-mode-map (kbd "<tab>") 'mydef-youdao-input)))


;; open fold tree
;;(global-set-key [f8] 'treemacs-toggle)


;; easy to change buffer
(global-set-key (kbd "<M-left>") 'previous-buffer)
(global-set-key (kbd "<M-right>") 'next-buffer)
(add-hook 'elpy-mode-hook
	  (lambda ()
	    (define-key elpy-mode-map (kbd "<M-left>") 'previous-buffer)
	    (define-key elpy-mode-map (kbd "<M-right>") 'next-buffer)
	    ))
(global-set-key (kbd "s-[") 'previous-buffer)
(global-set-key (kbd "s-]") 'next-buffer)

(global-set-key (kbd "<s-left>") 'winner-undo)
(global-set-key (kbd "<s-right>") 'winner-redo)

(global-set-key (kbd "M-p") 'backward-paragraph)
(global-set-key (kbd "M-n") 'forward-paragraph)

(global-set-key (kbd "<C-tab>") 'iedit-mode)

;; find the file at point
;;(global-set-key (kbd "C-c o") 'find-file-at-point)
;;(global-set-key (kbd "C-c C-o") 'find-file-at-point)
;;(global-set-key (kbd "C-c C-\\") 'find-file-in-project)
;;(global-set-key (kbd "C-c \\") 'find-file-in-project)

(define-key projectile-mode-map [?\s-p] 'projectile-switch-project)
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)

(defun mydef-enhanced-counsel-search ()
  "Enhanced the function of counsel-projectile-ag
if we are not in a project, just use the function counsel-ag"
  (interactive)
  (if (equal (projectile-project-name) "-")
      (progn
	(if (not (buffer-file-name))
	    (if (string-equal major-mode "dired-mode")
		(counsel-rg)
	     (swiper))
	  (counsel-rg)))
    (counsel-projectile-rg)))
(global-set-key (kbd "M-e") 'mydef-enhanced-counsel-search)

(require 'init-user-funs)
(defun mydef-enhanced-find-file ()
  "Enhanced the function of counsel-projectile-find-file
if we are not in a project, just use the function find-file"
  (interactive)
  (if (equal (projectile-project-name) "-")
      (counsel-files-search-jump)
    (mydef-counsel-projectile-find-file)))
(define-key projectile-mode-map [?\s-f] 'mydef-enhanced-find-file)

(defun mydef-enhanced-open-folder ()
  "Enhanced the function of counsel-projectile-find-file
if we are not in a project, just use the function find-file"
  (interactive)
  (if (equal (projectile-project-name) "-")
      (counsel-files-search-jump-to-folder)
    (mydef-counsel-projectile-open-folder)))
;;(define-key projectile-mode-map (kbd "s-d") 'mydef-enhanced-open-folder)


(global-set-key (kbd "M-SPC") 'set-mark-command)
(global-set-key (kbd "M-t") 'git-timemachine)


(provide 'init-keybindings)
