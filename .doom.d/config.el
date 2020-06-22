;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

(setq user-full-name "John Doe"
      user-mail-address "john@doe.com")

(setq doom-font "Fira Code")
(setq doom-theme 'doom-one)

(setq display-line-numbers-type t)

(setq org-directory "~/org/")
(setq org-ref-notes-directory "~/Dropbox/Notebook/References/Notes"
      org-ref-bibliography-notes "~/Dropbox/Notebook/References/notes.org"
      org-ref-default-bibliography "~/Dropbox/Notebook/References/master.bib"
      org-ref-pdf-directory "~/Dropbox/Library/")

(setq helm-bibtex-bibliography "~/Dropbox/Notebook/References/master.bib"
      helm-bibtex-library-path "~/Dropbox/Library/"
      helm-bibtex-notes-path "~/Dropbox/Notebook/References/notes.org")
