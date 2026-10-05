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

;;; Key bindings

(when (eq system-type 'darwin)
  (setq mac-command-modifier 'meta)
  (setq mac-option-modifier 'super))

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
  (isearch-allow-motion t)
  (mode-line-collapse-minor-modes t)
  (quit-window-kill-buffer t)
  (require-final-newline t)
  (ring-bell-function 'flash-face-bell-function)
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
	  ("Asia/Manila" "Philippines")))
  :bind
  (("C-<tab>" . previous-buffer)
   ("C-x C-b" . ibuffer)
   ("M-`" . other-frame)
   ("M-i" . imenu)
   ;; match M-z, zap-to-char
   ("M-Z" . zap-up-to-char)))

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

(use-package tab-bar
  :demand t
  :custom
  (tab-bar-mode t)
  (tab-bar-select-tab-modifiers '(super))
  (tab-bar-tab-hints t))

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

(use-package transient
  :bind ("C-z" . my-transient-menu)
  :config
  (defun my/toggle-status (desc mode)
    (lambda ()
      (format (concat desc " %s") (if (symbol-value mode) "●" "○"))))

  (defun my/org-finder ()
    (interactive)
    (ido-find-file-in-dir org-directory))

  (defun my/org-open-project-file ()
    "Open <project-name>.org in `org-directory' for the current project."
    (interactive)
    (if-let* ((project (project-current)))
	(find-file (expand-file-name (concat (project-name project) ".org")
                                   org-directory))
      (user-error "Not in a project")))

  (transient-define-prefix my-transient-menu ()
    "Personal command menu."
    :display-action
    '(display-buffer-below-selected
      (dedicated . t)
      (inhibit-same-window . t))
    [["Project"
      ("pb" "Buffer" consult-project-buffer)
      ("pd" "Dired" project-dired)
      ("pe" "Eshell" project-eshell)
      ("pf" "File" project-find-file)
      ("pg" "Ghostel" ghostel-project)
      ("ps" "Switch" project-switch-project)]
     ["LSP"
      ("ll" "Start eglot" eglot)
      ("la" "Code actions" eglot-code-actions)
      ("lr" "Rename" eglot-rename)
      ("lf" "Format buffer" eglot-format-buffer)
      ("li" "Implementation" eglot-find-implementation)
      ("lu" "References" xref-find-references)
      ("ld" "Diagnostics" flymake-show-buffer-diagnostics)
      ("lq" "Shutdown" eglot-shutdown)]
     ["Org"
      ("oa" "Agenda" org-agenda)
      ("oc" "Capture" org-capture)
      ("of" "Find" my/org-finder)
      ("op" "Project file" my/org-open-project-file)]
     ["Toggle"
      ("th" hl-line-mode
       :description ,(my/toggle-status "Highlight line" 'hl-line-mode)
       :transient t)
      ("tM" mode-line-invisible-mode
       :description ,(my/toggle-status "Hide mode line" 'mode-line-invisible-mode)
       :transient t)
      ("tm" markdown-toggle-markup-hiding
       :if (lambda () (derived-mode-p 'markdown-mode))
       :description ,(my/toggle-status "Markdown markup hiding" 'markdown-hide-markup)
       :transient t)
      ("tn" display-line-numbers-mode
       :description ,(my/toggle-status "Line numbers" 'display-line-numbers-mode)
       :transient t)]
     ["Other"
      ("b" "Browse URL" browse-url-at-point)
      ("f" "Elfeed" elfeed-search)
      ("g" "Magit" magit-status)
      ("m" "Mu4e" mu4e)
      ("q" "Quit" transient-quit-one)]]))

(use-package whitespace
  :demand t
  :custom
  (whitespace-line-column 100)
  (whitespace-style '(face lines-tail))
  :hook
  (before-save . delete-trailing-whitespace)
  (prog-mode . whitespace-mode))

;;; Global variables

(defvar my-org-directory "~/Dropbox/Documents/org")

;;; External packages

(load-file (locate-user-emacs-file "packages.el"))
(load-file (locate-user-emacs-file "mu4e.el"))
(load-file (locate-user-emacs-file "org.el"))

(message "Emacs loaded in: %s" (emacs-init-time))
