
(setq package-archives '(("gnu"   . "http://elpa.zilongshanren.com/gnu/")
                         ("melpa" . "http://elpa.zilongshanren.com/melpa/")))

;; TNUA ELPA
;; (setq package-archives
;;       '(("gnu"   . "http://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
;;         ("melpa" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")))

;; list the packages you want
(setq package-list '(use-package
		      auto-complete
		      highlight-parentheses
		      ;;neotree
		      ;;treemacs
		      ;;treemacs-projectile
		      swiper
		      counsel
		      ivy
		      autopair
		      avy
		      undo-tree
		      ;;window-numbering
		      yasnippet
		      ;;org-ac
		      browse-kill-ring
		      transpose-frame
		      iedit
		      auto-complete-auctex
		      expand-region
		      elpy
		      flycheck
		      py-autopep8
		      company
		      company-auctex
		      projectile
		      counsel-projectile
		      popwin
		      cal-china-x
		      ace-window
		      dim
		      hungry-delete
		      ztree
		      smart-mode-line
		      ))

;; activate all the packages (in particular autoloads)
;;(package-initialize)

;; fetch the list of packages available 
(unless package-archive-contents
  (package-refresh-contents))

;; install the missing packages
(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))(setq package-list '(package1 package2))


;; This is only needed once, near the top of the file
(eval-when-compile
  (require 'use-package))

(require 'counsel)
(use-package ivy-mode
  :commands ivy-mode
  :init
  (setq ivy-use-virtual-buffers t
	ivy-wrap t
	ivy-initial-inputs-alist nil
	ivy-count-format "(%d/%d) ")
  ;; set for the swiper
  (defun mydef-push-mark-swiper ()
    "push a mark to add the current position to the mark ring"
    (interactive)
    (push-mark)
    (swiper))
  :bind
  ("\C-s" . swiper)
  ("C-c C-r" . ivy-resume)
  ("<f6>" . ivy-resume)
  ("C-x C-b" . ivy-switch-buffer)
  ("M-x" . counsel-M-x)
  ("\C-xf" . counsel-find-file)
  ("C-x C-f" . counsel-find-file)
  ("<f1> f" . counsel-describe-function)
  ("<f1> v" . counsel-describe-variable)
  ("<f1> l" . counsel-find-library)
  ("<f2> i" . counsel-info-lookup-symbol)
  ("<f2> u" . counsel-unicode-char)
  ("C-x l" . counsel-locate)
  ("C-S-o" . counsel-rhythmbox)
  ("C-r" . counsel-expression-history)
  ("C-c C-g" . counsel-mark-ring)
  ("\C-xg" . counsel-bookmark)
  ("M-g" . counsel-projectile)
  )


(use-package projectile-mode
  :commands projectile-mode
  :init
  (counsel-projectile-mode 1)
  ;; using the local .projectile file for the file settings
  (setq projectile-indexing-method 'native)
  (setq projectile-enable-caching t)
  (setq projectile-completion-system 'ivy)
  (setq projectile-mode-line-function '(lambda ()
					 (format " P[%s]" (projectile-project-name))))
  )



;; (use-package company-mode
;;   :bind (:map company-active-map
;; 	      ("C-h". company-show-doc-buffer)
;; 	      ("C-n". company-select-next)
;; 	      ("C-p". company-select-previous)
;; 	      )
;;   :init
  (setq company-selection-wrap-around t
	company-tooltip-align-annotations t
	company-idle-delay 0
	company-minimum-prefix-length 2
	company-tooltip-limit 9
	company-show-numbers t)
  (global-company-mode)
  ;;(company-tng-configure-default)
  (add-hook 'elpy-mode-hook
            (lambda ()
              (set (make-local-variable 'company-backends)
                   (append company-backends '(company-yasnippet)))))
  (add-hook 'inferior-python-mode-hook
            (lambda ()
              (set (make-local-variable 'company-backends)
                   (append company-backends
			   '(company-yasnippet company-other-backend)))))
  ;; ;; (add-hook 'ess-mode-hook
  ;; ;; 	  (lambda ()
  ;; ;; 	    (set (make-local-variable 'company-backends)
  ;; ;; 		 (append company-backends '(company-yasnippet company-dabbrev-code)))))
  ;; (add-hook 'LaTeX-mode-hook
  ;; 	    (lambda ()
  ;; 	      (set (make-local-variable 'company-backends)
  ;; 		   (list
  ;; 		    (cons 'company-yasnippet
  ;; 			  (car company-backends))))))
  ;; (add-hook 'mhtml-mode-hook
  ;;           (lambda ()
  ;; 	      (set (make-local-variable 'company-backends)
  ;; 		   (list
  ;; 		    (cons 'company-yasnippet
  ;; 			  (car company-backends))))))
;;  )

;;(require 'company-tabnine)
;;(add-to-list 'company-backends #'company-tabnine)


(use-package ace-window
  :init
  (setq aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l))
  (defvar aw-dispatch-alist
    '((?x aw-delete-window "Delete Window")
      (?m aw-swap-window "Swap Windows")
      (?M aw-move-window "Move Window")
      (?j aw-switch-buffer-in-window "Select Buffer")
      (?n aw-flip-window)
      (?u aw-switch-buffer-other-window "Switch Buffer Other Window")
      (?c aw-split-window-fair "Split Fair Window")
      (?v aw-split-window-vert "Split Vert Window")
      (?b aw-split-window-horz "Split Horz Window")
      (?o delete-other-windows "Delete Other Windows")
      (?? aw-show-dispatch-help))
    "List of actions for `aw-dispatch-default'.")
  :bind
  ("M-o" . ace-window)
  ("M-0" . delete-window)
  ("M-1" . delete-other-windows)
  ("M-2" . split-window-below)
  ("M-3" . split-window-right)
  ("M-k" . kill-this-buffer)
  ("<f10>" . toggle-frame-maximized)
  ("M-\\" . nil)
  )


(use-package expand-region
  :bind
  ("C-=" . er/expand-region)
  ("C--" . er/contract-region))


(use-package yasnippet
  :init
  (yas-global-mode 1)
  )


;; (use-package hungry-delete
;;   :init
;;   (global-hungry-delete-mode))


(use-package autopair
  :init (autopair-global-mode 1))


(use-package undo-tree
  :init 
  (global-undo-tree-mode 1)
  )


(use-package youdao-dictionary
  :init
  (global-set-key (kbd "M-y") 'youdao-dictionary-search-at-point))


(use-package iedit)


(use-package avy
  :init
  (defun mydef-avy-goto-char ()
    "let avy-goto-char go to the below of the searching charachter"
    (interactive)
    (call-interactively 'avy-goto-char)
    (forward-char))
  (global-set-key [(control ?\;)] 'avy-goto-char)
  :bind
  ("C-'" . avy-goto-line)
  ;; ([(control ?\;)] . avy-goto-char)
  )


(use-package counsel)

(require 'yasnippet)
(yas-global-mode 1)

;; calendar of china
;; (require 'cal-china-x)
;; (setq mark-holidays-in-calendar t)
;; (setq cal-china-x-important-holidays cal-china-x-chinese-holidays)
;; (setq cal-china-x-general-holidays '((holiday-lunar 1 15 "元宵节")))
;; (setq other-holidays '((holiday-lunar 12 27 "Lisa's Birthday")))
;; (setq calendar-holidays
;;       (append cal-china-x-important-holidays
;; 	      cal-china-x-general-holidays
;; 	      other-holidays))


(provide 'init-packages)

