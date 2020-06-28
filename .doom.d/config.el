;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;; NOTE: Consider splitting this into separate files, and load them into this one.
;; NOTE: This is a great fuckin' config: https://github.com/glynnforrest/emacs.d/blob/master/site-lisp/setup-org.el

(setq user-full-name    "Jonathan Crum"
      user-mail-address "crumja@uga.edu")

;; Path Variables
(setq
 NOTEBOOK     (concat (getenv "HOME") "/Dropbox/Notebook")
 BIBLIOGRAPHY (concat (getenv "HOME") "/texmf/bibtex/bib/master.bib"))

(use-package! pdf-tools)
(use-package! rainbow-mode)
(use-package! direx)
(use-package! popwin)
(push '(direx:direx-mode :position left :width 25 :dedicated t)
      popwin:special-display-config)

;; PDF-View
(require 'pdf-view)
(setq pdf-info-epdfinfo-program "/usr/bin/epdfinfo")
(setq pdf-view-midnight-colors `(,(face-attribute 'default :foreground) .
                                 ,(face-attribute 'default :background)))
(add-to-list 'auto-mode-alist '("\\.pdf\\'" . pdf-view-mode))
(add-hook 'pdf-view-mode-hook (lambda ()
                                (pdf-view-midnight-minor-mode)))
(provide 'init-pdfview)

(remove-hook 'text-mode-hook #'auto-fill-mode)

(load! "+theming.el")
(load! "+notebook-suite.el")
(load! "+bindings")
(load! "+functions")
(load! "themes/doom-sakura-dark-theme.el")
(load! "themes/doom-sakura-light-theme.el")
