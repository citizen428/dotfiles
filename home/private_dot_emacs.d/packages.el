;; -*- lexical-binding: t; -*-

(use-package auto-dark
  :custom
  (auto-dark-themes '((modus-vivendi-tinted) (modus-operandi-tinted)))
  :config
  (defun my/server-auto-dark (frame)
    (with-selected-frame frame
      (when (display-graphic-p)
        (auto-dark-mode 1)
        (remove-hook 'after-make-frame-functions #'my/server-auto-dark))))
  (add-hook 'after-make-frame-functions #'my/server-auto-dark))

(use-package buffer-terminator
  :custom
  (buffer-terminator-verbose nil)
  (buffer-terminator-inactivity-timeout (* 2 60 60)) ; 2 hours
  (buffer-terminator-interval (* 30 60)) ; 30 minutes
  :init
  (buffer-terminator-mode 1))

(use-package consult
  :bind
  ("C-z M-x" . #'consult-mode-command)
  ("C-x 4 b" . consult-buffer-other-window)
  ("C-x b" . #'consult-buffer)
  ("M-g g" . #'consult-goto-line)
  ("M-g i" . #'consult-imenu)
  ("M-s l" . #'consult-line)
  ("M-s g" . #'consult-grep)
  ("M-s G" . #'consult-git-grep)
    ("M-y" . #'consult-yank-pop))

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

;; TODO: Update to Non-GNU ELPA once it releases there.
(use-package tramp-rpc
  :after tramp
  :vc (:url "https://github.com/ArthurHeymans/emacs-tramp-rpc"
       :rev :newest
       :lisp-dir "lisp"))

(use-package zig-mode)
