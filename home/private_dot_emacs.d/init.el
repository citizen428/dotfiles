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

(global-set-key (kbd "<escape>") #'keyboard-escape-quit)
(global-set-key (kbd "C-x C-b") #'ibuffer)
(global-set-key (kbd "M-`") #'other-frame)

;; My prefix keys (C-z)
(define-prefix-command 'my-prefix-map)
(global-set-key (kbd "C-<tab>") #'previous-buffer)
(global-set-key (kbd "C-z") 'my-prefix-map)
(define-key my-prefix-map (kbd "b") #'browse-url-at-point)
(define-key my-prefix-map (kbd "m") #'mu4e)
(define-prefix-command 'my-prefix-file-map)
(define-key my-prefix-map (kbd "f") 'my-prefix-file-map)
(define-key my-prefix-file-map (kbd "f") #'project-find-file)
(define-key my-prefix-file-map (kbd "r") #'recentf-open)
(define-prefix-command 'my-prefix-toggle-map)
(define-key my-prefix-map (kbd "t") 'my-prefix-toggle-map)
(define-key my-prefix-toggle-map (kbd "n") #'display-line-numbers-mode)
(define-key my-prefix-toggle-map (kbd "h") #'hl-line-mode)
(define-key my-prefix-toggle-map (kbd "w") #'which-key-mode)

;;; Internal packages (part of Emacs)

(use-package emacs
  :ensure nil
  :demand t
  :custom
  ;; Be less verbose
  (initial-scratch-message nil)
  (inhibit-startup-screen t)
  (server-client-instructions nil)
  ;; Modes
  (context-menu-mode t)
  (column-number-mode t)
  (delete-selection-mode t) ; Typing replaces current selection
  (editorconfig-mode t)
  (electric-pair-mode t)
  (global-xref-mouse-mode t)
  (pixel-scroll-mode t) ; Smoother scrolling
  (repeat-mode t) ; Skip prefix on repeat invocations for certain commands
  (savehist-mode t)
  ;; Mouse
  (mouse-drag-and-drop-region t)
  (mouse-drag-and-drop-region-cross-program t)
  (mouse-yank-at-point t)
  ;; Misc
  (dired-auto-revert-buffer t)
  (dired-mouse-drag-files t) ; C-left: copy, S-left: move, M-left: link
  (global-auto-revert-mode t) ; Reload files when changed externally
  (imenu-auto-rescan t) ; Update imenu based on current buffer
  (require-final-newline t)
  (ring-bell-function 'ignore)
  (shell-command-prompt-show-cwd t)
  (view-read-only t))

(use-package completion-preview
  :ensure nil
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
  :config
  (global-completion-preview-mode 1))

(use-package eglot
  :ensure nil
  :custom
  (eglot-autoshutdown t)
  (eglot-sync-connect nil)
  (eglot-events-buffer-config '(:size 0)))

(use-package minibuffer
  :ensure nil
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

(use-package whitespace
  :ensure nil
  :demand t
  :custom
  (whitespace-line-column 100)
  (whitespace-style '(face lines-tail))
  :config
  (add-hook 'before-save-hook #'delete-trailing-whitespace)
  (add-hook 'prog-mode #'whitespace-mode))

;;; External packages

(load-file (locate-user-emacs-file "packages.el"))
(load-file (locate-user-emacs-file "mu4e.el"))

(message "Emacs loaded in: %s" (emacs-init-time))
