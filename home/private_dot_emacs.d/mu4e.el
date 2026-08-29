;; -*- lexical-binding: t; -*-

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
  ;; General settings
  (mu4e-confirm-quit nil)
  (mu4e-hide-index-messages t)
  ;; Rename files when moving. Needed for mbsync.
  (mu4e-change-filenames-when-moving t)
  ;; Folders
  (mu4e-refile-folder "/Archive")
  (mu4e-sent-folder "/Sent")
  (mu4e-drafts-folder "/Drafts")
  (mu4e-trash-folder "/Trash")
  ;; Dashboard
  (mu4e-maildir-shortcuts
   '((:maildir "/INBOX"   :key ?i)
     (:maildir "/Sent"    :key ?s)
     (:maildir "/Archive" :key ?a)))
  (mu4e-bookmarks
   '((:name "Unread messages" :query "flag:unread AND NOT flag:trashed"
	    :key ?u :type bookmarks :count 0 :unread 0 :delta-count 0
	    :delta-unread 0 :maildir nil :effective-query
	    "flag:unread AND NOT flag:trashed")
     (:name "Today's messages" :query "date:today..now" :key ?t :type
	    bookmarks :count 0 :unread 0 :delta-count 0 :delta-unread 0
	    :maildir nil :effective-query "date:today..now")
     (:name "Last 7 days" :query "date:7d..now" :hide-unread t :key 119
	    :type bookmarks :count 0 :unread 0 :delta-count 0
	    :delta-unread 0 :maildir nil :effective-query "date:7d..now")
     (:name "Lists" :query "list:/.*/ AND NOT flag:trashed" :key ?l
	    :type bookmarks)))
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
  (message-kill-buffer-on-exit t))
