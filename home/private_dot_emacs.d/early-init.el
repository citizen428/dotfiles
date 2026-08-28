;; -*- lexical-binding: t; -*-

;; Unclutter UI
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(tooltip-mode -1)

(setq default-frame-alist
      '((fullscreen . maximized) (left-fringe . 5) (right-fringe . 5)
        (font . "FiraCode Nerd Font-14")))

;; Raise GC threshold during startup
(setq gc-cons-threshold 128000000
      gc-cons-percentage 0.6)

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
