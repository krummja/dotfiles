;;; ~/.doom.d/notebook-suite.el -*- lexical-binding: t; -*-

;; This configuration uses a few key org packages to streamline research and notetaking.
;; The fundamental principal is for the note system to get out of the way, but to maintain
;; discoverability and consistency.
;;
;; The notebook generates files monthly, which serve as central indices for Org-Roam based files.
;; Searching and finding information uses Deft.

;; Path Variables
(setq
 org-directory      NOTEBOOK
 deft-directory     NOTEBOOK
 org-roam-directory NOTEBOOK)

;; Deft
;; TODO: Keep?
(use-package! deft
  :commands deft
  :init
  (setq deft-default-extension "org"
        deft-use-filename-as-title nil
        deft-use-filter-string-for-filename t
        deft-auto-save-interval -1.0
        deft-file-naming-rules
        '((noslash . "-")
          (nospace . "-")
          (case-fn . downcase)))
  :config
  (add-to-list 'deft-extensions "text"))



;; Org-Noter
(use-package! org-noter)


;; Org-Ref
(use-package! org-ref
  :config
  (setq
   org-ref-completion-library 'org-ref-ivy-cite-completion
   org-ref-get-pdf-filename-function 'org-ref-get-pdf-filename-helm-bibtex
   org-ref-default-bibliography (list BIBLIOGRAPHY)
   org-ref-bibliography-notes (concat NOTEBOOK "reading-notes.org")
   org-ref-note-title-format "* TODO %y - %t\n :PROPERTIES:\n  :Custom_ID: %k\n  :NOTER_DOCUMENT: %F\n :ROAM_KEY: cite:%k\n  :AUTHOR: %9a\n  :JOURNAL: %j\n  :YEAR: %y\n  :VOLUME: %v\n  :PAGES: %p\n  :DOI: %D\n  :URL: %U\n :END:\n\n"
   org-ref-notes-directory NOTEBOOK
   org-ref-notes-function 'orb-edit-notes))

;; Org-Rifle
;; Rifle through those org files, you cool baby.
(use-package! helm-org-rifle)
;; TODO: Set up a keybinding for this!

;; Org-Roam
(use-package! org-roam
  :hook (org-load . org-roam-mode)
  :commands (
             org-road-buffer-toggle-display
             org-roam-find-file
             org-roam-graph
             org-roam-insert
             org-roam-switch-to-buffer)
  :preface
  (defvar org-roam-directory nil)
  :init
  :config
  (setq org-roam-directory NOTEBOOK
        org-roam-index-file (concat NOTEBOOK "index.org")
        org-roam-verbose nil
        org-roam-completion-system 'helm)

  (add-hook 'org-roam-buffer-prepare-hook #'hide-mode-line-mode))

(use-package! pdfgrep)
(use-package! zotxt)
