;; -*- lexical-binding: t; -*-

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

  (transient-define-prefix my-toggle-menu ()
    "Toggle menu."
    ["Toggle" :class transient-row
     ("h" hl-line-mode
      :description ,(my/toggle-status "Highlight line" 'hl-line-mode)
      :transient t)
     ("M" mode-line-invisible-mode
      :description ,(my/toggle-status "Hide mode line" 'mode-line-invisible-mode)
      :transient t)
     ("m" markdown-toggle-markup-hiding
      :if (lambda () (derived-mode-p 'markdown-mode))
      :description ,(my/toggle-status "Markdown markup hiding" 'markdown-hide-markup)
      :transient t)
     ("n" display-line-numbers-mode
      :description ,(my/toggle-status "Line numbers" 'display-line-numbers-mode)
      :transient t)]
    [("q" "Quit" transient-quit-all)])

  (transient-define-prefix my-denote-menu ()
    "Denote menu."
    ["Denote"
     [("n" "New note" denote)
      ("o" "Open or create" denote-open-or-create)
      ("r" "Rename file" denote-rename-file)
      ("l" "Insert link" denote-link)]
     [("b" "Backlinks" denote-backlinks)
      ("d" "Dired" denote-dired)
      ("g" "Grep" denote-grep)]]
    [("q" "Quit" transient-quit-all)])

  (transient-define-prefix my-lsp-menu ()
    "LSP menu."
    ["LSP"
     [("l" "Start eglot" eglot)
      ("a" "Code actions" eglot-code-actions)
      ("r" "Rename" eglot-rename)
      ("f" "Format buffer" eglot-format-buffer)]
     [("i" "Implementation" eglot-find-implementation)
      ("u" "References" xref-find-references)
      ("d" "Diagnostics" flymake-show-buffer-diagnostics)
      ("s" "Shutdown" eglot-shutdown)]]
    [("q" "Quit" transient-quit-all)])

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
     ["Org"
      ("oa" "Agenda" org-agenda)
      ("oc" "Capture" org-capture)
      ("of" "Find" my/org-finder)
      ("op" "Project file" my/org-open-project-file)]
     ["Other"
      ("e" "Emoji" emoji-insert)
      ("f" "Elfeed" elfeed-search)
      ("g" "Magit" magit-status)
      ("m" "Mu4e" mu4e)]
     [""
      ("d" "Denote" my-denote-menu)
      ("l" "LSP" my-lsp-menu)
      ("t" "Toggle" my-toggle-menu)
      ("q" "Quit" transient-quit-one)]]))
