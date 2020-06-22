;; -*- mode: emacs-lisp -*-

; ---------------------------------------------------------------------------- ;
;                               SAKURA SPACEMACS                               ;
; ---------------------------------------------------------------------------- ;
;                             Author: Jonathan Crum                            ;
;                            Version: 1.0                                      ;
;                            Updated: 2020/06/22                               ;
; ---------------------------------------------------------------------------- ;


; ---------------------------------------------------------------------------- ;
;                                    LAYERS                                    ;
; ---------------------------------------------------------------------------- ;
(defun dotspacemacs/layers ()
  (setq-default
   dotspacemacs-configuration-layer-path '((config  :location local)
                                           (display :location local))
   dotspacemacs-configuration-layers '("~/.spacemacs.d./layers/")
   dotspacemacs-additional-packages '()
   dotspacemacs-excluded-packages '()))


; ---------------------------------------------------------------------------- ;
;                                     INIT                                     ;
; ---------------------------------------------------------------------------- ;
(defun dotspacemacs/init ()
  (setq-default
   dotspacemacs-elpa-https t
   dotspacemacs-elpa-subdirectory nil
   dotspacemacs-editing-style 'hybrid
   dotspacemacs-startup-banner 'official
   dotspacemacs-startup-lists nil
   dotspacemacs-scratch-mode 'org-mode
   dotspacemacs-default-font
   '("Fira Code"
     :size 14
     :weight normal
     :width normal
     :powerline-scale 1.1
     )
   dotspacemacs-leader-key "SPC"
   dotspacemacs-emacs-command-key "SPC"
   dotspacemacs-auto-resume-layouts nil
   dotspacemacs-emacs-leader-key "M-m"
   dotspacemacs-mode-line-theme 'doom
   dotspacemacs-whitespace-cleanup 'trailing))


; ---------------------------------------------------------------------------- ;
;                                   FUNCTIONS                                  ;
; ---------------------------------------------------------------------------- ;
(defun my-save-if-bufferfilename()
  (if (buffer-file-name)
      (progn
        (save-buffer))
    (message "No file is associated with this buffer: doing nothing.")))


; ---------------------------------------------------------------------------- ;
;                                   USER INIT                                  ;
; ---------------------------------------------------------------------------- ;
(defun dotspacemacs/user-init ()
  ;; Package Archives
  (setq package-archives
        '(("marmalade"    . "http://marmalade-repo.org/packages/")
          ("melpa"        . "http://melpa.org/packages/")
          ("melpa-stable" . "https://stable.melpa.org/packages/")))
  (package-initialize)

  ;; Custom Settings File
  (setq custom-file "~/.spacemacs.d/.custom-settings.el")
  (load-file custom-file))


; ---------------------------------------------------------------------------- ;
;                                  USER CONFIG                                 ;
; ---------------------------------------------------------------------------- ;
(defun dotspacemacs/user-config ()
  ;; Requisites
  (require 'org)
  (require 'org-projectile)
  (require 'org-roam)


  ;; Keybinding Modifications
  (global-unset-key (kbd "C-z"))


  ;; User Variables
  ;;;; Paths
  (setq LATEX-PATH     "~/texmf")
  (setq LIBRARY-PATH   "~/Dropbox/Library" ) ;; For documents
  (setq NOTEBOOK-PATH  "~/Notebook")         ;; For research notes
  (setq WORKSPACE-PATH "~/Workspace")        ;; For programming

  ;;;; Workspace Directories
  (setq CLOJURE    (concatenate 'string WORKSPACE-PATH "/CLOJURE"))
  (setq CSHARP     (concatenate 'string WORKSPACE-PATH "/CSHARP"))
  (setq DART       (concatenate 'string WORKSPACE-PATH "/DART"))
  (setq LATEX      (concatenate 'string WORKSPACE-PATH "/LATEX"))
  (setq TYPESCRIPT (concatenate 'string WORKSPACE-PATH "/TYPESCRIPT"))

  ;;;; Endpoints
  (setq BIBLIOGRAPHY (concatenate 'string LATEX-PATH    "/bibtex/bib/master.bib"))
  (setq NOTES        (concatenate 'string NOTEBOOK-PATH "/notes.org"))
  (setq TEX-PREAMBLE (concatenate 'string LATEX-PATH    "/latex/tex/local/preamble.tex"))

  ;; Theming
  (setq doom-themes-enable-bold t
        doom-themes-enable-italic t)
  (load-theme 'doom-Iosvkem t)
  (require 'doom-modeline)
  (doom-modeline-mode 1)
  (setq-default line-spacing 1)


  ;; Package Configurations
  ;;;; BibTeX
  (setq bibtex-completion-bibliography BIBLIOGRAPHY)
  (setq bibtex-completion-library-path LIBRARY-PATH)
  (setq bibtex-completion-notes-path   NOTES)

  ;;;; Company
  (setq company-tooltip-align-annotations t)

  ;;;; LaTeX
  (setq TeX-auto-save t)
  (setq TeX-parse-self t)
  (setq org-latex-create-formula-image-program 'dvipng)
  (setq org-format-latex-options (plist-put org-format-latex-options :scale 1.5))
  (setq-default TeX-master nil)

  ;;;; Nov
  (add-to-list 'auto-mode-alist '("\\.epub\\'" . nov-mode))

  ;;;; Org-Mode
  (setq org-superstar-headline-bullets-list '("▶"))

  ;;;; Org-Noter
  (setq org-noter-separate-notes-from-heading t)
  (setq org-noter-default-notes-file-names NOTES)
  (setq org-noter-notes-search-path NOTEBOOK-PATH)

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
  (setq org-roam-directory NOTEBOOK-PATH)
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


  ;; Hooks
  ;;;; Auto-Saving
  (add-hook 'evil-hybrid-state-exit-hook 'my-save-if-bufferfilename)

  ;;;; Editing
  (add-hook 'text-mode-hook #'visual-line-mode)
  (add-hook 'org-mode-hook  #'org-indent-mode)
  (add-hook 'org-mode-hook  #'org-zotxt-mode)

  ;;;; LaTeX
  (add-hook 'LaTeX-mode-hook 'visual-line-mode)
  (add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)
  (add-hook 'LaTeX-mode-hook 'turn-on-reftex)
  (add-hook 'LaTeX-mode-hook (lambda ()
                               (push
                                '("arara" "arara %s" TeX-run-Tex nil t
                                  :help "Run arara on the current file.")
                                TeX-command-list))))
