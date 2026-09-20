;; -*- lexical-binding: t; -*-

;;; Emacs internals

(setq custom-file (locate-user-emacs-file "custom.el"))
(load custom-file 'noerror)

;; Move backup/auto-save files out of the way
(let ((backup-dir (locate-user-emacs-file "backups/"))
      (auto-save-dir (locate-user-emacs-file "auto-save/")))
  (make-directory backup-dir t)
  (make-directory auto-save-dir t)
  (setq backup-directory-alist `(("." . ,backup-dir)))
  (setq auto-save-file-name-transforms `((".*" ,auto-save-dir t)))
  (setq create-lockfiles nil))

;;; Keys

(when (eq system-type 'darwin)
  (setq mac-command-modifier 'meta)
  (setq mac-option-modifier 'super))

(keymap-global-set "C-<tab>" #'previous-buffer)
(keymap-global-set "C-x C-b" #'ibuffer)
(keymap-global-set "M-`" #'other-frame)
;; match M-z, zap-to-char
(keymap-global-set "M-Z" #'zap-up-to-char)

;; My prefix keys (C-z)
(define-keymap :prefix 'my-prefix-file-map
  "f" #'project-find-file
  "r" #'recentf-open)
(define-keymap :prefix 'my-prefix-toggle-map
  "n" #'display-line-numbers-mode
  "h" #'hl-line-mode
  "m" #'mode-line-invisible-mode)
(define-keymap :prefix 'my-prefix-project-map
  "b" #'consult-project-buffer
  "f" #'project-find-file)
(define-keymap :prefix 'my-prefix-map
  "b" #'browse-url-at-point
  "f" 'my-prefix-file-map
  "m" #'mu4e
  "t" 'my-prefix-toggle-map
  "p" 'my-prefix-project-map
  "\\" #'project-dired)
(keymap-global-set "C-z" 'my-prefix-map)

(windmove-default-keybindings 'super)
(windmove-display-default-keybindings '(shift super))

;;; Internal packages (part of Emacs)

(use-package emacs
  :demand t
  :custom
  ;; Be less verbose
  (initial-scratch-message nil)
  (inhibit-startup-screen t)
  (server-client-instructions nil)
  ;; Modes
  (column-number-mode t)
  (context-menu-mode t)
  (delete-selection-mode t) ; Typing replaces current selection
  (editorconfig-mode t)
  (electric-pair-mode t)
  (global-auto-revert-mode t) ; Reload files when changed externally
  (global-xref-mouse-mode t)
  (pixel-scroll-mode t) ; Smoother scrolling
  (repeat-mode t) ; Skip prefix on repeat invocations for certain commands
  (savehist-mode t)
  (which-key-mode t)
  ;; Mouse
  (mouse-drag-and-drop-region t)
  (mouse-drag-and-drop-region-cross-program t)
  (mouse-yank-at-point t)
  ;; Misc
  (dired-auto-revert-buffer t)
  (dired-mouse-drag-files t) ; C-left: copy, S-left: move, M-left: link
  (elisp-fontify-semantically t)
  (enable-recursive-minibuffers t)
  (help-window-select t)
  (imenu-auto-rescan t) ; Update imenu based on current buffer
  (mode-line-collapse-minor-modes t)
  (quit-window-kill-buffer t)
  (require-final-newline t)
  (ring-bell-function 'ignore)
  (select-active-regions nil)
  (shell-command-prompt-show-cwd t)
  (switch-to-buffer-obey-display-actions t)
  (use-package-enable-imenu-support t)
  (view-read-only t)
  (world-clock-list
	'(("US/Pacific" "US Pacific")
	  ("US/Central" "US Central")
	  ("US/Eastern" "US Eastern")
	  ("Etc/UTC" "UTC")
	  ("Europe/Vienna" "Austria")
	  ("Asia/Karachi" "Pakistan")
	  ("Asia/Kolkata" "India")
	  ("Asia/Bangkok" "Thailand")
	  ("Asia/Manila" "Philippines"))))

(use-package completion-preview
  :demand t
  :diminish
  :bind
  (:map completion-preview-active-mode-map
	("M-i" . completion-preview-insert-word)
	("M-n" . completion-preview-next-candidate)
	("M-p" . completion-preview-prev-candidate)
	("M-<return>" . completion-preview-insert)
	("<tab>" . completion-preview-complete))
  :custom
  (completion-preview-minimum-symbol-length 2)
  (completion-show-help nil)
  (completion-styles '(basic flex))
  (global-completion-preview-mode t))

(use-package dired
  :config
  (defun my/dired-copy-project-filename-as-kill ()
    "Copy the filename relative to the project root to the kill ring."
    (interactive)
    (dired-copy-filename-as-kill 1))
  :bind
  (:map dired-mode-map
	("W" . my/dired-copy-project-filename-as-kill)))

(use-package eglot
  :custom
  (eglot-autoshutdown t)
  (eglot-sync-connect nil)
  (eglot-events-buffer-config '(:size 0)))

(use-package eshell
  :custom
  (eshell-command-aliases-list
   '(("d" "dired $1")
     ("ff" "find-file $1")
     ("ll" "ls -l $@*"))))

(use-package flyspell
  :custom
  (flyspell-delay-use-timer t)
  :hook
  (prog-mode . flyspell-prog-mode)
  (text-mode . flyspell-mode))

(use-package minibuffer
  :demand t
  :bind
  (:map completion-in-region-mode-map
	("M-i" . minibuffer-choose-completion)
	("M-n" . minibuffer-next-completion)
	("M-p" . minibuffer-previous-completion))
  :custom
  (completions-auto-help t)
  (completions-detailed t)
  (completion-eager-update t)
  (completions-format 'one-column)
  (completions-max-height 15)
  (completions-sort 'historical)
  (minibuffer-visible-completions t))

(use-package theme
  :no-require t
  :when (bound-and-true-p ns-emacs-plus-version)
  :config
  (defun my/apply-theme (appearance)
    "Load theme, taking current system APPEARANCE into consideration."
    (mapc #'disable-theme custom-enabled-themes)
    (pcase appearance
      ('light (load-theme 'modus-operandi-tinted t))
      ('dark (load-theme 'modus-vivendi-tinted t))))
  (add-hook 'ns-system-appearance-change-functions #'my/apply-theme))

(use-package whitespace
  :demand t
  :custom
  (whitespace-line-column 100)
  (whitespace-style '(face lines-tail))
  :hook
  (before-save . delete-trailing-whitespace)
  (prog-mode . whitespace-mode))

;;; External packages

(load-file (locate-user-emacs-file "packages.el"))
(load-file (locate-user-emacs-file "mu4e.el"))

(message "Emacs loaded in: %s" (emacs-init-time))
