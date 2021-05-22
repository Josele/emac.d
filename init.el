;; My config
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

;; Getting evil and biding it to key
(use-package evil
	     :ensure t)
(global-set-key (kbd "<f12>") 'evil-mode)
;;(evil-mode)

;; Custom function to write to a terminal
(defun py-compile()
  (interactive)
  (with-current-buffer "pyterm"
    (goto-char (point-max))
    (term-send-raw-string "python -u steer_mfcc8558_ldra_sca_tc.py\n")
    ))

;; lsp-mode for using emacs as IDE
(defun efs/lsp-mode-setup ()
  (setq lsp-headerline-breadcrumb-segments '(path-up-to-project file symbols))
  (lsp-headerline-breadcrumb-mode))

(use-package lsp-mode
	     :commands (lsp lsp-deferred)
	     :hook (lsp-mode . efs/lsp-mode-setup)
	     :init
	     (setq lsp-keymap-prefix "C-c l")  ;; Or 'C-l', 's-l'
	     :config
	     (lsp-enable-which-key-integration t))

;;Make sure you have the pyls language server installed before trying lsp-mode!
;;pip install --user "python-language-server[all]"
(use-package python-mode
	     :ensure t
	     :hook (python-mode . lsp-deferred)
	     :custom
	     ;; NOTE: Set these if Python 3 is called "python3" on your system!
	     (python-shell-interpreter "python3.6")
	     ;;(dap-python-executable "python3")
	     ;;(dap-python-debugger 'debugpy)
	     ;;  :config
	     ;;  (require 'dap-python)
	     )


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(python-mode lsp-mode evil-escape which-key use-package evil)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
