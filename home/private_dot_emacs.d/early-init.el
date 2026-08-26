;; -*- lexical-binding: t; -*-

;; Leave my init.el alone
(setq custom-file (locate-user-emacs-file "custom.el"))
(load custom-file 'noerror)

;; Set up packages
(setq package-archives
      '(("melpa" . "https://melpa.org/packages/")
        ("org" . "https://orgmode.org/elpa/")
        ("elpa" . "https://elpa.gnu.org/packages/")))

(package-initialize)

(unless package-archive-contents
 (package-refresh-contents))

(require 'use-package)
(setq use-package-always-ensure t)

;; Automatically reload files changed outside Emacs
(global-auto-revert-mode)

;; Move backup/auto-save files out of the way
(let ((backup-dir (locate-user-emacs-file "backups/"))
      (auto-save-dir (locate-user-emacs-file "auto-save/")))
  (make-directory backup-dir t)
  (make-directory auto-save-dir t)
  (setq backup-directory-alist `(("." . ,backup-dir)))
  (setq auto-save-file-name-transforms `((".*" ,auto-save-dir t)))
  (setq create-lockfiles nil))

