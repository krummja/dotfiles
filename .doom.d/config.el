;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

(setq user-full-name "Jonathan Crum"
      user-mail-address "crumja@uga.edu")

(setq
    NOTEBOOK      (concat (getenv "HOME") "/Notebook/")
    BIBLIOGRAPHY  (concat (getenv "HOME") "/texmf/bibtex/bib/master.bib")
    org-directory         NOTEBOOK
    deft-directory        NOTEBOOK
    org-roam-directory    NOTEBOOK
    )

;; Deft
(use-package deft
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
  (add-to-list 'deft-extensions "tex"))

;; Helm Bibtex
(setq
    bibtex-completion-notes-path    NOTEBOOK
    bibtex-completion-bibliography  BIBLIOGRAPHY
    bibtex-completion-pdf-field     "file"
    bibtex-completion-notes-template-multiple-files
    (concat
        "#+TITLE: ${title}\n"
        "#+ROAM_KEY: cite:${=key}\n"
        "* TODO Notes\n"
        ":PROPERTIES:\n"
        ":Custom_ID: ${=key=}\n"
        ":NOTER_DOCUMENT: %(orb-process-file-field \"${=key=}\")\n"
        ":AUTHOR: ${author-abbrev}\n"
        ":JOURNAL: ${journaltitle}\n"
        ":DATE: ${date}\n"
        ":YEAR: ${year}\n"
        ":DOI: ${doi}\n"
        ":URL: ${url}\n"
        ":END:\n\n"))

;; Org-Ref
(use-package org-ref
    :config
    (setq
        org-ref-completion-library 'org-ref-ivy-cite
        org-ref-get-pdf-filename-function 'org-ref-get-pdf-filename-helm-bibtex
        org-ref-default-bibliography (list BIBLIOGRAPHY)
        org-ref-bibliography-notes (concat (NOTEBOOK) "/bibnotes.org")
        org-ref-note-title-format "* TODO %y - %t\n :PROPERTIES:\n :Custom_ID: %k\n :NOTER_DOCUMENT: %f\n :ROAM_KEY: cite:%k\n :AUTHOR: %9a\n :JOURNAL: %j\n :YEAR: %y\n :VOLUME: %v\n :PAGES: %p\n :DOI: %D\n :URL: %U\n :END:\n\n"))

;; Org-Roam
(use-package org-roam
  :hook (org-load .org-roam-mode)
  :commands (org-roam-buffer-toggle-display
             org-roam-find-file
             org-roam-graph
             org-roam-insert
             org-roam-switch-to-buffer
             org-roam-dailies-date
             org-roam-dailies-today
             org-roam-dailies-tomorrow
             org-roam-dailies-yesterday)
  :preface
  ;; Set this to nil so we can later detect whether the user has set a custom
  ;; directory for it, and default to `org-directory' if they haven't.
  (defvar org-roam-directory nil)
  :init
  :config
  (setq org-roam-directory (expand-file-name (or org-roam-directory "roam")
                                             org-directory)
        org-roam-verbose nil
        org-roam-buffer-no-delete-other-windows t
        org-roam-completion-system 'default

        (add-hook 'find-file-hook
                  (defun +org-roam-open-buffer-maybe-h ()
                    (and +org-roam-open-buffer-on-find-file
                         (memq 'org-roam-buffer--update-maybe post-command-hook)
                         (not (window-parameter nil 'window-side))
                         (not (eq 'visible (org-roam-buffer--visibility)))
                         (with-current-buffer (window-buffer)
                           (org-roam-buffer--get-create)))))

        (add-hook 'org-roam-buffer-prepare-hook #'hide-mode-line-mode)))

(use-package org-roam-protocol
  :after org-protocol)

(use-package company-org-roam
    :after org-roam
    :config
    (set-company-backend! 'org-mode '(company-org-roam company-yasnippet company-dabbrev)))

(use-package org-roam-bibtex
    :after (org-roam)
    :hook (org-roam-mode . org-roam-bibtex-mode)
    :config
    (setq org-roam-bibtex-preformat-keywords
          '("=key=" "title" "url" "file" "author-or-editor" "keywords"))
    (setq orb-templates
          '(("r" "ref" plain (function org-roam-capture--get-point)
             ""
             :file-name "${slug}"
             :head "#+TITLE: ${=key=}: ${title}\n#+ROAM_KEY: ${ref}

- tags ::
- keywords :: ${keywords}

\n* ${title}\n  :PROPERTIES:\n  :Custom_ID: ${=key=}\n  :URL: ${url}\n  :AUTHOR: ${author-or-editor}\n  :NOTER_DOCUMENT: %(orb-process-file-field \"${=key=}\")\n  :NOTER_PAGE: \n  :END:\n\n"

           :unnarrowed t))))

;; Org-Noter
(use-package org-noter
    :after (:any org pdf-view)
    :config
    (setq
        org-noter-notes-window-location 'other-frame
        org-noter-always-create-frame nil
        org-noter-hide-other nil
        org-noter-notes-search-path (list NOTEBOOK)))

;; PDFgrep

;; PDF-Tools

;; Zotxt

(setq doom-font (font-spec :family "Fira Code" :size 10))
(setq doom-theme 'doom-one)

(setq display-line-numbers-type t)
