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

(setq
 initial-scratch-message nil
 inhibit-startup-screen t
 server-client-instructions nil)

;;; Editing / Behavior

;; Show column in modeline
(column-number-mode 1)

(setq
 require-final-newline t
 ring-bell-function 'ignore)

;; Automatically reload files changed outside Emacs
(global-auto-revert-mode)

;; Completion settings
(setq
 tab-always-indent 'complete
 completion-auto-select 'second-tab
 completion-styles '(basic flex)
 completions-format 'one-column
 completions-max-height 20)
(global-completion-preview-mode)
(fido-vertical-mode)

;; Whitespace handling
(setq
 whitespace-line-column 100
 whitespace-style '(face lines-tail))
(global-whitespace-mode)

;;; Hooks

(add-hook 'before-save-hook #'delete-trailing-whitespace)

(add-hook 'prog-mode-hook #'eglot-ensure)

;;; Keys

(when (eq system-type 'darwin)
  (setq mac-command-modifier 'meta)
  (setq mac-option-modifier 'super))

(global-set-key (kbd "<escape>") 'keyboard-escape-quit)
(global-set-key (kbd "C-x C-b") 'ibuffer)

(define-prefix-command 'my-prefix-map)
(global-set-key (kbd "C-z") 'my-prefix-map)
(define-key my-prefix-map (kbd "f f") #'project-find-file)
(define-key my-prefix-map (kbd "f r") #'recentf-open)
(define-key my-prefix-map (kbd "t n") #'display-line-numbers-mode)
(define-key my-prefix-map (kbd "t h") #'hl-line-mode)

;;; Packages

(use-package diminish
  :config
  (diminish 'completion-preview-mode)
  (diminish 'whitespace-mode))

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

(use-package exec-path-from-shell
  :config
  (when (daemonp)
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
  (:map
   my-prefix-map
   ("g" . magit-status)))

(use-package mu4e
  :ensure nil
  :load-path
  (lambda ()
    (concat (file-name-directory
             (directory-file-name
              (file-name-directory (file-truename (executable-find "mu")))))
            "share/emacs/site-lisp/mu/mu4e"))
  :custom
  (mu4e-mu-binary (executable-find "mu"))
  ;; folders
  (mu4e-refile-folder "/Archive")
  (mu4e-sent-folder "/Sent")
  (mu4e-drafts-folder "/Drafts")
  (mu4e-trash-folder "/Trash")
  ;; Retrieving
  (mu4e-get-mail-command (concat (executable-find "mbsync") " -a"))
  (mu4e-update-interval 300)
  ;; sending
  (user-full-name "Michael Kohl")
  (user-mail-address "me@citizen428.net")
  (sendmail-program (executable-find "msmtp"))
  (send-mail-function #'message-send-mail-with-sendmail)
  (message-sendmail-f-is-evil t)
  (message-sendmail-extra-arguments '("--read-envelope-from"))
  (message-send-mail-function #'message-send-mail-with-sendmail)
  ;; Rename files when moving. Needed for mbsync.
  (setq mu4e-change-filenames-when-moving t))

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

;; TODO: Update to Non-GNU ELPA once it releases there.
(use-package tramp-rpc
  :after tramp
  :vc (:url "https://github.com/ArthurHeymans/emacs-tramp-rpc"
       :rev :newest
       :lisp-dir "lisp"))

(use-package zig-mode)

(message "Emacs loaded in: %s" (emacs-init-time))
