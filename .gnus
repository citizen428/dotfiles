(setq gnus-select-method '(nnimap "gmail"
                                  (nnimap-address "imap.gmail.com")
                                  (nnimap-server-port 993)
                                  (nnimap-stream ssl)))

(setq message-send-mail-function 'smtpmail-send-it
      smtpmail-starttls-credentials '(("smtp.gmail.com" 587 nil nil))
      smtpmail-default-smtp-server "smtp.gmail.com"
      smtpmail-auth-credentials '(("smtp.gmail.com" 587 "citizen428@gmail.com" nil))
      smtpmail-smtp-server "smtp.gmail.com"
      smtpmail-smtp-service 587)

(setq mail-host-address "gmail.com")
(setq user-full-name "Michael Kohl")
(setq user-mail-address "citizen428@gmail.com")

;; enable aspell to check written text
; (add-hook 'message-mode-hook (lambda () (flyspell-mode 1)))


