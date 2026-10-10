;; -*- lexical-binding: t; -*-

(use-package org
  :ensure t
  :preface
  ;; Based on https://isamert.net/2026/10/04/opening-org-capture-in-a-new-frame.html
  (defun my/global-org-capture (&optional capture-fn &rest args)
    "Select a template and capture in a new frame.
With CAPTURE-FN, call it with ARGS instead of `org-capture'.  This
allows using the function as :around advice for `org-protocol-capture'."
    (interactive)
    (let ((frame (make-frame '((name . "org-capture")
			       (fullscreen . nil)
                               (width . 80)
                               (height . 20)
			       (undecorated . t)
                               (internal-border-width . 5)
                               (left-fringe . 0)
                               (right-fringe . 0)
                               (menu-bar-lines . 0)
                               (tool-bar-lines . 0)
                               (vertical-scroll-bars . nil)
                               (horizontal-scroll-bars . nil)
                               (tab-bar-lines . 0)))))
      (select-frame-set-input-focus frame)
      (condition-case err
          (let ((display-buffer-overriding-action
                 '(display-buffer-same-window
                   (inhibit-same-window . nil))))
            (apply (or capture-fn #'org-capture) args))
        ((quit user-error)
         (when (frame-live-p frame)
           (delete-frame frame))
         (message "%s" (or (cadr err) "Quit"))
         ;; org-protocol must not get a string back, emacsclient would
         ;; treat it as a file name.
         nil))))

  (defun my/delete-frame-after-capture ()
    "Delete the current frame after org-capture is finished.
Does nothing while refiling, `org-capture-refile' is advised to call
this again once the refile is done."
    (when (and (not org-capture-is-refiling)
               (equal (frame-parameter nil 'name) "org-capture"))
      (delete-frame)))
  :custom
  (org-directory my-org-directory)
  (org-agenda-files (list my-org-directory))
  (org-refile-targets '((org-agenda-files . t)))
  (org-capture-templates
   '(("t" "Task" entry (file+headline "inbox.org" "Tasks")
      "* TODO %?")
     ("l" "Link" entry (file+headline "inbox.org" "Links")
      "* %?[[%:link][%:description]]\nCaptured On: %U" :prepend t)
     ("p" "Link with body" entry (file+headline "inbox.org" "Links")
      "* %?[[%:link][%:description]]\nCaptured On: %U\n#+BEGIN_QUOTE\n%i\n#+END_QUOTE" :prepend t)))
  (org-startup-indented t)
  (org-todo-keywords
   '((sequence "TODO(t)" "STARTED(s)" "WAITING(w)" "|" "DONE(d)" "CANCELED(c)")))
  :bind
  ("C-c l" . org-store-link)
  :hook
  (org-capture-after-finalize . my/delete-frame-after-capture)
  :config
  (require 'org-protocol)
  (require 'org-tempo)
  (advice-add 'org-protocol-capture :around #'my/global-org-capture)
  (advice-add 'org-capture-refile :after #'my/delete-frame-after-capture))

(use-package org-modern
  :ensure t
  :custom
  (org-modern-star 'replace)
  (org-modern-hide-stars ?\s)
  :hook
  (org-mode . org-modern-mode))

(use-package ox-hugo
  :ensure t
  :pin melpa
  :after ox)
