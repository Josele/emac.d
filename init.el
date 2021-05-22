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

;; Getting evil and bind to key
(use-package evil
	     :ensure t)
(global-set-key (kbd "<f12>") 'evil-mode)

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
    (python-mode lsp-mode evil-escape which-key use-package evil))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
