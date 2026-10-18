;; -*- lexical-binding: t; -*-

;; Unclutter UI
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(tooltip-mode -1)

(setopt default-frame-alist
      '((fullscreen . maximized) (left-fringe . 5) (right-fringe . 5)
        (font . "FiraCode Nerd Font-14")))

;; Raise GC threshold during startup
(setopt gc-cons-threshold 128000000
      gc-cons-percentage 0.6)

;; Stricter TLS settings
(setopt gnutls-verify-error t)
(setopt tls-checktrust t)
(setopt gnutls-min-prime-bits 3072)

;; Set up packages
(setopt package-archives
      '(("melpa" . "https://melpa.org/packages/")
        ("org" . "https://orgmode.org/elpa/")
        ("elpa" . "https://elpa.gnu.org/packages/")))

(setopt package-quickstart t)

(require 'use-package)
