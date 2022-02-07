;; My config
;; Setup emacs to behave civilised.
(transient-mark-mode t)
(setq visible-bell t)

;;Initialize package source
(require 'package)

(setq package-archives '(("melpa" . "https://melpa.org/packages/")
			 ("org" . "https://orgmode.org/elpa/")
			 ("elpa" . "https://elpa.gnu.org/packages/")))

(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

;; Set ESC to c+g
;;(global-set-key (kbd "<escape>") 'keyboard-quit)

;; Initialize use-package on non-Linux platforms
(unless (package-installed-p 'use-package)
  (package-install 'use-package))

;; Install and enable packages with use-package
(require 'use-package)
(setq use-package-always-ensure t)

;; Description of the key commands
(use-package which-key)
;;(require 'which-key)

(which-key-mode)

;;Powerline import from submodules
;;https://www.emacswiki.org/emacs/powerline.el
(add-to-list 'load-path "~/.emacs.d/vendor/emacs-powerline")
(require 'powerline)
;;Utilities for better Evil support for Powerline
;;https://github.com/johnson-christopher/powerline-evil.
(add-to-list 'load-path "~/.emacs.d/vendor/powerline-evil")

;; Getting evil, configure and bind to key
(use-package evil
  :ensure t)
(define-key evil-normal-state-map (kbd "C-r") 'undo-redo)
(global-set-key (kbd "<f12>") 'evil-mode)
(add-hook 'evil-mode (show-paren-mode t))
(require 'powerline-evil)
(powerline-evil-vim-color-theme)
;; Tabs to 4
(setq-default tab-width 4)
;;Fine undo 
(setq evil-want-fine-undo t) 
;; Other bindings
(global-set-key [f1] 'compare-windows)
(global-set-key [f2] 'compile)
(global-set-key [f3] 'next-error)
(global-set-key [(shift f3)] 'previous-error)

;; Custom  function to write to terminal
(defun send-cmd(param)
  (interavtice "sCmd: ")
  (with-current-buffer "*terminal*"
    (goto-char (point-may))
    (setq cmd (concat param "\n"))
    (term-send-raw-string cmd)
    ))


;; Experimental features
;; Emacs as a C++ IDE
(setq c-default-style "linux"
      c-basic-offset 4)
(defun compact-format ()
  "Set tabulation with 4 spaces"
  (interactive)
  (save-excursion
    (setq tab-width 4)
    (setq-default indent-tabs-mode nil)
    (setq c-basic-offset 4)))

(defun linux-format ()
  "Set tabulation with tabulation character"
  (interactive)
  (save-excursion
    (setq tab-width 8)
    (setq-default indent-tabs-mode t)
    (setq c-basic-offset 8)))
;;(defun my-c-indent-setup ()
;;  (setq c-basic-offset 4)
;;  (setq indent-tabs-mode nil)
;;  (setq-default fill-column 80))
(add-hook 'c-mode-common-hook 'linum-mode)
(add-hook 'c-mode-common-hook '(lambda () (c-toggle-auto-hungry-state 1)))
(add-hook 'c-mode-common-hook '(lambda () (c-toggle-auto-newline 1)))

;;(add-hook 'c-mode-common-hook 'compact-format)

;; Emacs ts and js
(use-package js2-mode)
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
(add-to-list 'auto-mode-alist '("\\.ts\\'" . js2-mode))
(use-package js2-refactor)
(add-hook 'js2-mode-hook
		  (lambda ()
			(setq js2-basic-offset 4)
			(setq indent-tabs-mode nil)
			))
(add-hook 'js2-mode-hook #'js2-refactor-mode)

;; ;;Projectile: This library provides easy project management and navigation
(require 'subr-x)
(use-package projectile
  :ensure t
  :init
  (projectile-mode +1)
  :bind (:map projectile-mode-map
	      ("s-p" . projectile-command-map)
              ("C-x p" . projectile-command-map)))

(setq projectile-project-search-path '("~/Source/cpp_workarea/"))
;;
(use-package typescript-mode)
;; lsp-mode for using emacs as IDE
(defun efs/lsp-mode-setup ()
  (setq lsp-headerline-breadcrumb-segments '(path-up-to-project file symbols))
  (lsp-headerline-breadcrumb-mode))

(use-package lsp-mode
	     :commands (lsp lsp-deferred)
	     :hook (lsp-mode . efs/lsp-mode-setup)
	     :init
	     (setq lsp-keymap-prefix "C-c l")  ;; Or 'C-l', 's-l'
	     (setq gc-cons-threshold 100000000)
          :config
	     (lsp-enable-which-key-integration t))
;; ;;Too slow 
;; ;;Make sure you have the pyls language server installed before trying lsp-mode!
;; ;;pip install --user "python-language-server[all]"
;; (use-package python-mode
;; 	     :ensure t
;; 	     :hook (python-mode . lsp-deferred)
;; 	     :custom
;; 	     ;; NOTE: Set these if Python 3 is called "python3" on your system!
;; 	     (python-shell-interpreter "python3.6")
;; 	     ;;(dap-python-executable "python3")
;; 	     ;;(dap-python-debugger 'debugpy)
;; 	     ;;  :config
;; 	     ;;  (require 'dap-python)
;; 	     )


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
	(js2-refactor js2-mode projectile company python-mode lsp-mode evil-escape which-key use-package evil))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
