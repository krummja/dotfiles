;; -*- mode: emacs-lisp -*-

(require 'deft)
(require 'org)
(require 'org-noter)
(require 'org-ref)
(require 'org-roam)
(require 'pdfgrep)
(require 'pdf-tools)
(require 'reftex)
(require 'zotxt)

  ;;;; Deft
  (use-package deft
    :commands deft
    :init
    (setq deft-default-extension "org"
          deft-use-filename-as-title nil
          deft-use-filter-string-for-filename t
          deft-auto-save-interval -1.0
          deft-directory NOTEBOOK-PATH
          deft-file-naming-rules
          '((noslash . "-")
            (noslash . "-")
            (case-fn . downcase)))
    :config
    (add-to-list 'deft-extensions "tex"))

  ;;;; Org-Mode
  (setq org-superstar-headline-bullets-list '("▶"))

  ;;;; Org-Noter
  (setq org-noter-always-create-frame nil)
  (setq org-noter-insert-note-no-questions t)
  (setq org-noter-separate-notes-from-heading t)
  (setq org-noter-autosave-last-location t)
  (setq org-noter-default-notes-file-names '("Research Notes"))
  ;;(setq org-noter-notes-search-path NOTEBOOK-PATH)

  ;;;; Org-Projectile
  (setq org-projectile-projects-file (concatenate 'string WORKSPACE-PATH "/projects.org"))
  (push (org-projectile-project-todo-entry) org-capture-templates)
  (setq org-agenda-files (append org-agenda-files (org-projectile-todo-files)))
  (global-set-key (kbd "C-c n p") 'org-projectile-project-todo-completing-read)

  ;;;; Org-Ref
  (setq org-ref-default-bibliography BIBLIOGRAPHY)
  (setq org-ref-pdf-directory        LIBRARY-PATH)
  (setq org-ref-bibliography-notes   NOTES)

  ;;;; Org-Roam
  (setq org-roam-index-file (concatenate 'string NOTEBOOK-PATH "/index.org"))
  (define-key org-roam-mode-map (kbd "C-c n l") #'org-roam)
  (define-key org-roam-mode-map (kbd "C-c n f") #'org-roam-find-file)
  (define-key org-roam-mode-map (kbd "C-c n j") #'org-roam-jump-to-index)
  (define-key org-roam-mode-map (kbd "C-c n b") #'org-roam-switch-to-buffer)
  (define-key org-roam-mode-map (kbd "C-c n g") #'org-roam-graph)
  (define-key org-mode-map (kbd "C-c n i") #'org-roam-insert)
  (org-roam-mode +1)

  ;;;; PDF-View
  (require 'pdf-view)
  (setq pdf-info-epdfinfo-program "/usr/bin/epdfinfo")
  (setq pdf-view-midnight-colors `(,(face-attribute 'default :foreground) .
                                   ,(face-attribute 'default :background)))
  (add-to-list 'auto-mode-alist '("\\.pdf\\'" . pdf-view-mode))
  (add-hook 'pdf-view-mode-hook (lambda ()
                                  (pdf-view-midnight-minor-mode)))
  (provide 'init-pdfview)

  ;;;; Reftex
  (setq reftex-default-bibliography BIBLIOGRAPHY)

  ;;;; Zotxt
  (defconst zotxt-url-base "http://localhost:23119/zotxt")

(provide 'sakura)
