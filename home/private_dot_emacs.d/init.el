;; -*- lexical-binding: t; -*-

;;; Keys

(when (eq system-type 'darwin)
  (setq mac-command-modifier 'meta)
  (setq mac-option-modifier 'super))

(global-set-key (kbd "<escape>") 'keyboard-escape-quit)
(global-set-key (kbd "C-x C-b") 'ibuffer)

(define-prefix-command 'my-prefix-map)
(global-unset-key (kbd "C-z"))  ; remove default binding (suspend-frame)
(global-set-key (kbd "C-z") 'my-prefix-map)
(define-key my-prefix-map (kbd "t n") #'global-display-line-numbers-mode)
(define-key my-prefix-map (kbd "f f") #'project-find-file)
(define-key my-prefix-map (kbd "f r") #'recentf-open)

;;; Packages

(use-package diminish)

(use-package auto-dark
  :diminish
  :custom
  (auto-dark-themes '((modus-vivendi-tinted) (modus-operandi-tinted)))
  :config
  (defun my/server-auto-dark (frame)
    (with-selected-frame frame
      (when (display-graphic-p)
        (auto-dark-mode 1)
        (remove-hook 'after-make-frame-functions #'my/server-auto-dark))))
  (add-hook 'after-make-frame-functions #'my/server-auto-dark))

(use-package completion-preview
  :diminish
  :config
  (setq tab-always-indent 'complete)
  (setf
   completion-auto-select 'second-tab
   completion-styles '(basic flex)
   completions-format 'one-column
   completions-max-height 20)
  :init
  (global-completion-preview-mode)
  (fido-vertical-mode))

(use-package eglot
  :hook (prog-mode . eglot-ensure))

(use-package exec-path-from-shell
  :config
  (when (memq window-system '(mac ns x pgtk))
    (dolist (var '("SSH_AUTH_SOCK"))
      (add-to-list 'exec-path-from-shell-variables var))
    (exec-path-from-shell-initialize)))

(use-package ghostel
  :bind
  ("C-`" . my/toggle-ghostel-panel)
  :init
  (defun my/toggle-ghostel-panel ()
    "Toggle a ghostel terminal in a side window along the bottom of the frame."
    (interactive)
    (if-let* ((win (seq-find
                    (lambda (w)
                      (and (eq (window-parameter w 'window-side) 'bottom)
                           (with-current-buffer (window-buffer w)
                             (derived-mode-p 'ghostel-mode))))
                    (window-list))))
        (delete-window win)
      (let ((display-buffer-overriding-action
             '((display-buffer-in-side-window)
               (side . bottom)
               (slot . 0)
               (window-height . 0.33)
               (dedicated . t)
               (preserve-size . (nil . t)))))
        (ghostel-project)))))

(use-package magit
  :bind
  (:map my-prefix-map
        ("g" . magit-status)))

(use-package obsidian
  :init
  (define-prefix-command 'my-obsidian-map)
  (define-key my-prefix-map "o" 'my-obsidian-map)
  :config
  (global-obsidian-mode t)
  (obsidian-backlinks-mode t)
  :custom
  (obsidian-directory "~/Obsidian")
  ;; Default location for new notes from `obsidian-capture'
  (obsidian-inbox-directory "Inbox")
  :bind
  (:map my-obsidian-map
        ("n" . obsidian-capture)
        ("l" . obsidian-insert-link)
        ("o" . obsidian-follow-link-at-point)
        ("s" . obsidian-jump)
        ("b" . obsidian-backlink-jump)))

(use-package whitespace
  :ensure nil
  :diminish
  :custom
  (whitespace-line-column 100)
  (whitespace-style '(face lines-tail))
  :config
  (global-whitespace-mode))

(use-package zig-mode)

(message "Emacs loaded in: %s" (emacs-init-time))
