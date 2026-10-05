;; -*- lexical-binding: t; -*-

(use-package org
  :ensure t
  :custom
  (org-directory my-org-directory)
  (org-agenda-files (list my-org-directory))
  (org-refile-targets '((org-agenda-files . t)))
  (org-todo-keywords '((sequence "TODO(t)" "STARTED(s)" "WAITING(w)" "|" "DONE(d)" "CANCELED(c)")))
  :bind ("C-c l" . org-store-link))

(use-package org-modern
  :ensure t
  :hook
  (org-mode . org-modern-mode))
