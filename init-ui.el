(if (get-buffer "*ESS*")
    (kill-buffer "*ESS*")
  )

(blink-cursor-mode 0)
(defun s-cursor()
  ;; set cursor-type with a line
  ;;(setq-default cursor-type 'bar)
  ;; set cursor color
  (set-cursor-color "#007ed9")
  )
(if window-system
    (s-cursor))

(menu-bar-mode -1)
(tool-bar-mode -1)
(set-face-attribute 'fringe nil :background nil)

(unless (display-graphic-p)
  (menu-bar-mode -1))
;; (unless (display-graphic-p)
;;   (load-theme 'spacemacs-dark t))

;;(load-theme 'sanityinc-tomorrow-eighties t)
;;(load-theme 'spacemacs-dark t)

(setq truncate-lines nil)
(setq truncate-partial-width-Win nil)
(add-hook 'org-mode-hook (lambda () (setq truncate-lines nil)))

;; line-spacing
(setq-default line-spacing 6)
;;(sml/setup)
;;(setq sml/projectile-replacement-format "")

(setq modelinesize 105)
(set-face-attribute 'mode-line nil :height modelinesize)
(set-face-attribute 'mode-line-inactive nil  :height modelinesize)
(toggle-frame-maximized)

(show-paren-mode 1)

(require 'highlight-parentheses)
(define-globalized-minor-mode global-highlight-parentheses-mode
  highlight-parentheses-mode
  (lambda ()
    (highlight-parentheses-mode t)))
(global-highlight-parentheses-mode t)


;; color of selected background
;;(set-face-attribute 'region nil :background "#94c9ff")

;; show number in the left
;;(global-linum-mode t)


;; highlight current line
(global-hl-line-mode +1)
;;(set-face-background 'hl-line "grey9")
(unless (display-graphic-p)
  (global-hl-line-mode +1)
  (set-face-background 'hl-line "#121212"))


;; show the search results number
(defun mydef-isearch-update-post-hook()
  (let (suffix num-before num-after num-total-set-keyal)
    (setq num-before (count-matches isearch-string (point-min) (point)))
    (setq num-after (count-matches isearch-string (point) (point-max)))
    (setq num-total (+ num-before num-after))
    (setq suffix (if (= num-total 0)
                     ""
                   (format "  [%d of %d]" num-before num-total)))
    (setq isearch-message-suffix-add suffix)
    (isearch-message)))
(add-hook 'isearch-update-post-hook 'mydef-isearch-update-post-hook)


;; hide the mode in the mode-line
(defvar hidden-minor-modes ; example, write your own list of hidden
  '(abbrev-mode            ; minor modes
    helm-mode
    undo-tree-mode
    auto-complete-mode
    inf-haskell-mode
    haskell-indent-mode
    haskell-doc-mode
    highlight-parentheses-mode
    autopair-mode
    yas-global-mode
    yas-minor-mode
    ivy-mode
    visual-line-mode
    auto-fill-mode
    Latex-mode
    latex-mode
    tex-mode
    TeX-mode
    reftex-mode
    disable-mouse-mode
    auto-fill-function
    hungry-delete-mode
    auto-revert-mode
    buffer-face-mode
    highlight-indentation-mode
    ))

(defun purge-minor-modes ()
  (interactive)
  (dolist (x hidden-minor-modes nil)
    (let ((trg (cdr (assoc x minor-mode-alist))))
      (when trg
        (setcar trg "")))))
(add-hook 'after-change-major-mode-hook 'purge-minor-modes)

(dim-major-name 'help-mode "H")
(dim-major-name 'emacs-lisp-mode "L")
(dim-major-name 'inferior-python-mode "iPy")
(dim-major-name 'python-mode "Py")

;; set default font for different OS type
;;(setq Win-English-font "-outline-Inconsolata-normal-normal-normal-mono-19-*-*-*-c-*-fontset-auto8")
(setq Win-English-font "-outline-Consolas-normal-normal-normal-mono-19-*-*-*-c-*-iso8859-1")
(setq Win-Chinese-font "-outline-Microsoft YaHei UI-normal-normal-normal-sans-17-*-*-*-p-*-iso8859-1")
(setq Win-fontsize 19)
(setq Win-smaller-fontsize 100)
(setq Mac-English-font "-*-Inconsolata-normal-normal-normal-*-20-*-*-*-m-0-iso10646-1")
(setq Mac-Chinese-font "-*-Hiragino Sans GB-normal-normal-normal-*-*-*-*-*-p-0-iso10646-1")
(setq Mac-fontsize 16)
(setq Mac-smaller-fontsize 132)
;; check OS type
(cond
 ((string-equal system-type "windows-nt") ; Microsoft Windows
  (progn
    (setq English-font Win-English-font)
    (setq Chinese-font Win-Chinese-font)
    (setq Font-size Win-fontsize)
    (setq Smaller-fontsize Win-smaller-fontsize)))
 ((string-equal system-type "darwin") ; Mac OS X
  (progn
    (setq English-font Mac-English-font)
    (setq Chinese-font Mac-Chinese-font)
    (setq Font-size Mac-fontsize)
    (setq Smaller-fontsize Mac-smaller-fontsize)))
 ((string-equal system-type "gnu/linux") ; linux
  (progn
    (message "Linux"))))

(defun s-font()
  (set-face-attribute
   'default nil
   :font (font-spec :name English-font
		    :weight 'normal
		    :slant 'normal
		    :size Font-size))
  (dolist (charset '(kana han symbol cjk-misc bopomofo))
    (set-fontset-font
     (frame-parameter nil 'font)
     charset
     (font-spec :name Chinese-font
		:weight 'normal
		:slant 'normal)))
  (setq face-font-rescale-alist '(("Hiragino Sans GB" . 1.05))))
(if window-system
    (s-font))

;; set font for org mode
(defun org-font()
  (set-face-attribute
   'default nil
   :font (font-spec :name English-font
		    :weight 'normal
		    :slant 'normal
		    :size Font-size))
  (dolist (charset '(kana han symbol cjk-misc bopomofo))
    (set-fontset-font
     (frame-parameter nil 'font)
     charset
     (font-spec :name Chinese-font
		:weight 'normal
		:slant 'normal)))
  (setq face-font-rescale-alist '(("Hiragino Sans GB" . 1.1))))
(defun my-buffer-face-mode-smaller ()
  "font in the inferiror python or ess mode"
  (interactive)
  (org-font)
  (buffer-face-mode))
(add-hook 'org-mode-hook 'my-buffer-face-mode-smaller)

;; smaller font for some buffer
(defun my-buffer-face-mode-smaller ()
  "font in the inferiror python or ess mode"
  (interactive)
  (setq buffer-face-mode-face '(:family "Inconsolata" :height 115))
  (buffer-face-mode))
(add-hook 'inferior-python-mode-hook 'my-buffer-face-mode-smaller)
(add-hook 'inferior-ess-mode-hook 'my-buffer-face-mode-smaller)
(defun ui-latex-mode ()
  "font in the inferiror python or ess mode"
  (interactive)
  (setq buffer-face-mode-face '(:family "Consolas" :height 145))
  (buffer-face-mode))
(add-hook 'LaTeX-mode-hook 'ui-latex-mode)


;;;; Set env of edit
(setq locale-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-buffer-file-coding-system 'utf-8)
(set-default buffer-file-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(modify-coding-system-alist 'process "*" 'utf-8)
(setq default-process-coding-system '(utf-8 . utf-8))
;; Path 
(setq-default pathname-coding-system 'utf-8)
;; file name
(setq file-name-coding-system 'utf-8)

;; always open files in the same window
(setq ns-pop-up-frames nil)

;; choose horizon window if proper
;;(setq split-width-threshold 140)

;;show file path
;; (setq frame-title-format
;;       '((:eval (if (buffer-file-name)
;;                    (abbreviate-file-name (buffer-file-name))
;;                  "%b"))))

;; (setq fancy-splash-image nil)

(setenv "LC_ALL" "en_US.UTF-8")

(provide 'init-ui)

