(server-start)
(setq inhibit-startup-message t)
(setq visible-bell t)
(setq delete-old-versions t
      kept-new-versions 6
      kept-old-versions 2
      version-control t)
(setq-default fill-column 80)

(scroll-bar-mode -1)
(tool-bar-mode -1)
(tooltip-mode -1)
(menu-bar-mode -1)

(set-fringe-mode 10)

(setq custom-file (concat user-emacs-directory "custom.el"))
(load custom-file 'noerror)

(setq backup-directory-alist `(("." . "~/.saves")))
(setq backup-by-copying t)
(setq delete-old-versions t
      kept-new-versions 6
      kept-old-versions 2
      version-control t)

(setq user-full-name "Jonathan Crum")
(setq user-mail-address "crumja@uga.edu")

(setq NOTEBOOK (concat (getenv "HOME") "/Notebook"))
(setq BIBLIOGRAPHY (concat (getenv "HOME") "/texmf/bibtex/bib/master.bib"))
(setq LIBRARY (concat (getenv "HOME") "/Dropbox/Library"))
(setq WORKSPACE (concat (getenv "HOME") "/Workspace"))

(require 'package)  ; Initialize package sources
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
			 ("melpa-stable" . "https://stable.melpa.org/packages/")
			 ("org" . "https://orgmode.org/elpa/")
			 ("elpa" . "https://elpa.gnu.org/packages/")))
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

(unless (package-installed-p 'use-package)
  (package-install 'use-package))
(require 'use-package)
(setq use-package-always-ensure t)

(push "~/.emacs.d/elisp" load-path)

(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

(use-package undo-tree)
(require 'undo-tree)
(global-undo-tree-mode)

(use-package evil
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  (setq evil-want-C-u-scroll t)
  (setq evil-want-C-i-jump nil)
  (setq evil-respect-visual-line-mode t)
  (setq evil-undo-system 'undo-tree)
  :config
  (evil-mode 1)
  (define-key evil-insert-state-map (kbd "C-g") 'evil-normal-state)
  (define-key evil-insert-state-map (kbd "C-h") 'evil-delete-backward-char-and-join)

  (evil-global-set-key 'motion "j" 'evil-next-visual-line)
  (evil-global-set-key 'motion "k" 'evil-previous-visual-line))

(use-package evil-collection
  :after evil
  :custom
  (evil-collection-outline-bind-tab-p nil)
  :config
  (evil-collection-init))

(with-eval-after-load 'evil-maps
  (define-key evil-motion-state-map (kbd "SPC") nil)
  (define-key evil-motion-state-map (kbd "RET") nil)
  (define-key evil-motion-state-map (kbd "TAB") nil))

(use-package which-key
  :init (which-key-mode)
  :diminish which-key-mode
  :config
  (setq which-key-idle-delay 0))	; controls how quickly which-key pops up

(use-package general
  :config
  (general-evil-setup t)
  (general-create-definer sakura/leader-key-def
			  :keymaps '(normal insert visual emacs)
			  :prefix "SPC"
			  :global-prefix "C-SPC")
  (general-create-definer sakura/ctrl-c-keys
			  :prefix "C-c"))

(sakura/leader-key-def 
  "t" '(:ignore t :which-key "toggles")
  "tt" '(counsel-load-theme :which-key "choose theme"))

(use-package page-break-lines)
(use-package all-the-icons)
(use-package dashboard
  :ensure t
  :config
  (dashboard-setup-startup-hook))

(column-number-mode)
(global-display-line-numbers-mode -1)

(set-face-attribute 'default nil 
		    :font "Fira Code Retina"
		    :height 120)

(set-face-attribute 'fixed-pitch nil
		    :font "Fira Code Retina"
		    :height 120)

;(set-face-attribute 'variable-pitch nil
;		    :font "ETBembo"
;		    :height 160
;		    :weight 'regular)

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1)
  :custom ((doom-modeline-height 15)))

(use-package eshell-toggle
  :bind ("C-`" . eshell-toggle)
  :custom
  (eshell-toggle-size-fraction 3)
  (eshell-toggle-use-projectile-root t)
  (eshell-toggle-run-command nil))

(use-package ivy
  :diminish			; suppresses minor mode on modeline
  :bind (("C-s" . swiper)	; allows fuzzy searching within current buffer
	 :map ivy-minibuffer-map
	 ("TAB" . ivy-alt-done)
	 ("C-l" . ivy-alt-done)
	 ("C-j" . ivy-next-line)
	 ("C-k" . ivy-previous-line)
	 :map ivy-switch-buffer-map
	 ("C-k" . ivy-previous-line)
	 ("C-l" . ivy-done)
	 ("C-d" . ivy-switch-buffer-kill)
	 :map ivy-reverse-i-search-map
	 ("C-k" . ivy-previous-line)
	 ("C-d" . ivy-reverse-i-search-kill))
  :config
  (setq ivy-use-selectable-prompt t)
  (ivy-mode 1))

(use-package ivy-rich
  :init
  (ivy-rich-mode 1))

(use-package counsel
  :bind (("M-x" . counsel-M-x)
	 ("C-x b" . counsel-ibuffer)
	 ("C-x C-f" . counsel-find-file)
	 :map minibuffer-local-map
	 ("C-r" . 'counsel-minibuffer-history)))

(sakura/leader-key-def
  "SPC" '(counsel-find-file :which-key "find file"))

(use-package ace-window
  :bind (("M-o" . ace-window))
  :config
  (setq aw-keys '(?h ?j ?k ?l)))

(sakura/leader-key-def 
  "w" '(:ignore t :which-key "windows")
  "w-" 'split-window-vertically
  "w/" 'split-window-horizontally
  "wd" 'delete-window
  "wh" 'evil-window-left
  "wl" 'evil-window-right
  "wk" 'evil-window-up
  "wj" 'evil-window-down)

(sakura/leader-key-def
  "o" '(:ignore t :which-key "open")
  "of" 'make-frame)

(sakura/leader-key-def
  "b" '(:ignore t :which-key "buffer")
  "bb" '(switch-to-buffer :which-key "switch-to-buffer")
  "bd" '(kill-buffer :which-key "kill-buffer"))

(sakura/leader-key-def
  "C-m" '(:ignore t :which-key "bookmarks")
  "C-m n" '(bookmark-set :which-key "bookmark-set")
  "C-m d" '(bookmark-delete :which-key "bookmark-delete")
  "C-m C-m" '(bookmark-bmenu-list :which-key "bookmark-list"))

(sakura/leader-key-def
  "n" '(:ignore t :which-key "notebook")
  "nb" '(:ignore t :which-key "bibtex"))

(use-package projectile
  :diminish projectile-mode
  :config (projectile-mode)
  :bind-keymap
  ("C-c p" . projectile-command-map)
  :init
  (when (file-directory-p "~/Workspace")
    (setq projectile-project-search-path '("~/Workspace")))
  (setq projectile-switch-project-action #'projectile-dired))

(use-package counsel-projectile
  :after projectile)

(sakura/leader-key-def
  "p" '(:ignore t :which-key "projectile")
  "pf" '(counsel-projectile-find-file :which-key "find file"))

(use-package neotree)
(setq neo-theme (if (display-graphic-p) 'icons 'arrow))
(add-hook 'neo-after-create-hook
	  (lambda (&rest _) (display-line-numbers-mode -1)))

(sakura/leader-key-def
  "t`" '(neotree-toggle :which-key "neotree"))

(defun sakura/org-mode-setup ()
  (org-indent-mode)
  (auto-fill-mode 0)
  (visual-line-mode 1)
  (setq evil-auto-indent nil))

(use-package org
  :defer t
  :hook (org-mode . sakura/org-mode-setup)
  :config
  (setq org-hide-emphasis-markers t
	org-src-fontify-natively t
	org-src-tab-acts-natively t
	org-edit-src-content-indentation 0
	org-hide-block-startup nil
	org-src-preserve-indentation nil
	org-startup-folded t
	org-cycle-separator-lines 2
	org-directory NOTEBOOK
	org-return-follows-link t)

  (setq org-refile-targets '((nil :maxlevel . 3)
			     (org-agenda-files :maxlevel . 3)))
  (setq org-outline-path-complete-in-steps nil)
  (setq org-refile-use-outline-path t)

  (evil-define-key '(normal insert visual) org-mode-map (kbd "C-j") 'org-next-visible-heading)
  (evil-define-key '(normal insert visual) org-mode-map (kbd "C-k") 'org-previous-visible-heading)

  (evil-define-key '(normal insert visual) org-mode-map (kbd "M-j") 'org-metadown)
  (evil-define-key '(normal insert visual) org-mode-map (kbd "M-k") 'org-metaup))

(use-package org-bullets
  :after org
  :hook (org-mode . org-bullets-mode)
  :custom
  (org-bullets-bullet-list '("☰" "☷" "☵" "☲" "☳" "☴" "☶" "☱")))

(require 'org-indent)

(font-lock-add-keywords 'org-mode
                        '(("^ *\\([-]\\) "
			   (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "•"))))))

(sakura/leader-key-def
  "l" '(:ignore t :which-key "links")
  "ll" '(org-store-link :which-key "org-store-link")
  "li" '(org-insert-link :which-key "org-insert-link")
  "lI" '(org-insert-all-links :which-key "org-insert-all-links"))

(setq org-agenda-files '("~/Notebook"))
(setq org-agenda-format-date 
      (lambda (date) (concat "\n"
			     (make-string (window-width) 9472)
			     "\n"
			     (org-agenda-format-date-aligned date))))

(setq org-agenda-custom-commands
      '(("c" "Simple agenda view"
	 ((tags "PRIORITY=\"A\""
		((org-agenda-skip-function '(org-agenda-skip-entry-if 'todo 'done))
		 (org-agenda-overriding-header "High-priority unfinished tasks:")))
	  (agenda "" ((org-agenda-ndays 1)))
	  (alltodo ""
		   ((org-agenda-skip-function '(or
						(sakura/org-skip-subtree-if-habit)
						(sakura/org-skip-subtree-if-priority ?A)
						(org-agenda-skip-if nil '(scheduled deadline))))
		    (org-agenda-overridding-header "\n\nALL normal priority tasks:"))))
	 ((org-agenda-block-separator "------------------------------------------")))))

(defun sakura/org-skip-subtree-if-priority (priority)
  "Skip an agenda subtree if it has a priority of PRIORITY.

PRIORITY may be one of the characters ?A, ?B or ?C."
  (let ((subtree-end (save-excursion (org-end-of-subtree t)))
	(pri-value (* 1000 (- org-lowest-priority priority)))
	(pri-current (org-get-priority (thing-at-point 'line t))))
    (if (= pri-value pri-current)
	subtree-end
      nil)))
		   
(defun sakura/org-skip-subtree-if-habit ()
  "Skip an agenda entry if it has a style property equal to \"habit\"."
  (let ((subtree-end (save-excursion (org-end-of-subtree t))))
    (if (string= (org-entry-get nil "STYLE") "habit")
	subtree-end
      nil)))

(sakura/leader-key-def
  "na" '(org-agenda :which-key "agenda"))



(defun sakura/org-path (path)
  (expand-file-name path org-directory))

(setq org-journal-dir (sakura/org-path "Journal/"))

(defun sakura/get-todays-journal-file-name ()
  "Gets the journal file for today's date."
  (interactive)
  (let* ((journal-file-name
         (expand-file-name
          (format-time-string "%Y/%Y-%2m-%B.org")
          org-journal-dir))
         (journal-year-dir (file-name-directory journal-file-name)))
        (if (not (file-directory-p journal-year-dir))
                (make-directory journal-year-dir))
        journal-file-name))

(use-package org-journal
  :defer t
  :ensure t
  :custom
  (org-journa-file-type 'daily)
  (org-journal-date-format "%B %d, %Y - %A")
  (org-journal-dir "~/Notebook/Journal/")
  (org-journal-time-format "%-l:%M %p - ")
  (org-journal-file-format "%Y-%m-%d.org")
  (org-journal-enable-agenda-integration t))

(sakura/leader-key-def
  "j" '(:ignore t :which-key "journal")
  "jj" '(org-journal-new-entry :which-key "new entry"))

(setq org-html-validation-link nil)
(require 'org-protocol)
(setq org-capture-templates
      '(("o" "Link capture" entry
	 (file+headline "~/Notebook/org-linkz/Linkz.org" "INBOX")
	 "* %a %U"
	 :immediate-finish t)))
(setq org-protocol-default-template-key "o")

(use-package helm-bibtex
  :defer t
  :config 
  (setq bibtex-completion-bibliography BIBLIOGRAPHY)
  (setq bibtex-completion-library-path LIBRARY)
  (setq bibtex-completion-pdf-field "File")
  (setq bibtex-completion-notes-path NOTEBOOK)
  (setq bibtex-completion-display-formats 
	'((article       . "${=has-pdf=:1}${=has-note=:1} ${=type=:3} ${year:4} ${author:36} ${title:80} ${journal:30}")
	  (inbook        . "${=has-pdf=:1}${=has-note=:1} ${=type=:3} ${year:4} ${author:36} ${title:80} Chapter ${chapter:26}")
	  (incollection  . "${=has-pdf=:1}${=has-note=:1} ${=type=:3} ${year:4} ${author:36} ${title:80} ${booktitle:30}")
	  (inproceedings . "${=has-pdf=:1}${=has-note=:1} ${=type=:3} ${year:4} ${author:36} ${title:80} ${booktitle:30}")
	  (t             . "${=has-pdf=:1}${=has-note=:1} ${=type=:3} ${year:4} ${author:36} ${title:80}")))
  (setq bibtex-completion-notes-template-multiple-files
        (concat
         "#+TITLE: ${title}\n"
         "#+ROAM_KEY: cite:${=key=}\n"
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
         ":END:")))

(use-package helm-swoop)

(sakura/leader-key-def
  "s" '(:ignore t :which-key "search")
  "ss" '(helm-swoop :which-key "swoop")
  "sa" '(helm-multi-swoop-all :which-key "swoop all the things")
  "sp" '(helm-multi-swoop-projectile :which-key "swoop project")
  "so" '(helm-multi-swoop-org :which-key "swoop org")
  "sc" '(helm-multi-swoop-current-mode :which-key "swoop same as current"))

;; Note: I need to figure out how to make C-j and C-k work in the occur buffer.

(use-package org-noter
  :after (:any org pdf-view)
  :config
  (setq org-noter-notes-window-location 'other-frame)
  (setq org-noter-always-create-frame nil)
  (setq org-noter-hide-other nil)
  (setq org-noter-notes-search-path '("~/Notebook")))

(sakura/leader-key-def 
  "nn" '(:ignore t :which-key "noter")
  "nnn" '(org-noter :which-key "org-noter")
  "nni" '(org-noter-insert-note :which-key "insert note")
  "nnI" '(org-noter-insert-precise-note :which-key "insert note precise"))

(use-package org-ref
  :after (:any org org-noter org-roam)
  :config
  (setq reftex-default-bibliography BIBLIOGRAPHY)

  (setq org-ref-bibliography-notes "~/Notebook/index.org")
  (setq org-ref-default-bibliography '("~/texmf/bibtex/bib/master.bib"))
  (setq org-ref-pdf-directory "~/Dropbox/Library")
  (setq org-ref-completion-library 'helm-bibtex)
  (setq org-ref-get-pdf-filename-function 'org-ref-get-pdf-filename-helm-bibtex)
  (setq org-ref-note-title-format "* TODO %y - %t\n :PROPERTIES:\n  :Custom_ID: %k\n  :NOTER_DOCUMENT: %F\n :ROAM_KEY: cite:%k\n  :AUTHOR: %9a\n  :JOURNAL: %j\n  :YEAR: %y\n  :VOLUME: %v\n  :PAGES: %p\n  :DOI: %D\n  :URL: %U\n :END:\n\n")
  (setq org-ref-notes-directory "~/Notebook")
  (setq org-ref-notes-function 'orb-edit-notes))

  (setq bibtex-completion-bibliography BIBLIOGRAPHY)
  (setq bibtex-completion-library-path LIBRARY)
  (setq bibtex-completion-notes-path NOTEBOOK)

(sakura/leader-key-def
  "nbb" '(helm-bibtex :which-key "helm-bibtex")
  "nbn" '(helm-bibtex-with-notes :which-key "helm-bibtex-with-notes"))

(use-package org-roam
  :ensure t
  :hook (after-init . org-roam-mode)
  :config
  (setq org-roam-directory NOTEBOOK))

(sakura/leader-key-def
  "nr" '(:ignore t :which-key "roam")
  "nrr" '(org-roam :which-key "org-roam")
  "nrf" '(org-roam-find-file :which-key "org-roam-find-file")
  "nrg" '(org-roam-graph-show :which-key "org-roam-graph-show")
  "nri" '(org-roam-insert :which-key "org-roam-insert")
  "nrI" '(org-roam-insert-immediate :which-key "org-roam-insert-immediate"))

(require 'org-roam-protocol)

(use-package org-roam-server
  :ensure t
  :config
  (setq org-rome-server-host "127.0.0.1"
	org-roam-server-port 8080
	org-roam-server-authenticate nil
	org-roam-server-export-inline-images t
	org-roam-server-files nil
	org-roam-server-served-file-extensions '("pdf" "md" "tex" "bib")
	org-roam-server-network-poll t
	org-roam-server-network-arrows nil
	org-roam-server-network-label-truncate t
	org-roam-server-label-truncate-length 60
	org-roam-server-network-label-wrap-length 20))

(sakura/leader-key-def
  "nrv" '(org-roam-server-mode :which-key "visualize roam"))

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

(sakura/leader-key-def
  "nba" '(orb-note-actions :which-key "orb-note-actions"))

(use-package pdf-tools
  :if (display-graphic-p)
  :mode ("\\.pdf$" . pdf-view-mode)
  :init (load "pdf-tools-autoloads" nil t)
  :config
  (pdf-tools-install)
  (setq-default pdf-view-display-size 'fit-width)
  (add-hook 'pdf-view-mode-hook (lambda () (cua-mode 0))))

(use-package powerthesaurus)

(sakura/leader-key-def
  "nt" '(powerthesaurus-lookup-word-dwim :which-key "powerthesaurus"))

(use-package zotxt
  :hook (after-init . org-zotxt-mode))
(sakura/leader-key-def
  "z"   '(:ignore t :which-key "zotero")
  "zi"  '(org-zotxt-insert-reference-link :which-key "insert reference")
  "zo"  '(org-zotxt-open-attachment :which-key "open attachment")
  "zu"  '(org-zotxt-update-reference-link-at-point :which-key "update reference")
  "zn"  '(org-zotxt-noter :which-key "take notes"))

(use-package smartparens)
(require 'smartparens-config)

(use-package markdown-mode
  :pin melpa-stable
  :mode "\\.md\\'"
  :config
  (setq markdown-command "marked"))

(use-package elpy
  :ensure t
  :init
  (elpy-enable))
(setq python-shell-interpreter "python3")
(setq py-shell-name "python3")
(setq py-python-command "python3")

(use-package company
  :diminish company-mode
  :init
  (global-company-mode)
  :config
  (setq company-backends 
        '((company-files
           company-keywords
	   company-capf)
	   (company-abbrev company-dabbrev)
           )))

(use-package company-quickhelp
  :config
  (company-quickhelp-mode))

(use-package rust-mode)
(use-package cargo)
(add-hook 'rust-mode-hook 'cargo-minor-mode)
(add-hook 'rust-mode-hook
	  (lambda ()
	    (local-set-key (kbd "C-c <tab>") #'rust-format-buffer)))
(use-package racer
  :config
  (setq racer-cmd "~/.cargo/bin/racer/")
  (setq racer-rust-src-path "~/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/lib/rustlib/src/"))

(add-hook 'rust-mode-hook #'racer-mode)
(add-hook 'rust-mode-hook #'smartparens-mode)
(add-hook 'racer-mode-hook #'eldoc-mode)
(add-hook 'racer-mode-hook #'company-mode)

(use-package flycheck-rust)
(add-hook 'flycheck-mode-hook #'flycheck-rust-setup)

(setq custom-theme-load-path '("~/.emacs.d/themes/"))
(use-package doom-themes
  :config
  (setq doom-themes-enable-bold t
	doom-themes-enable-italic t)
  (load-theme 'doom-sakura-light t)
  (doom-themes-visual-bell-config))

(set-face-attribute 'org-block nil :foreground nil :inherit 'fixed-pitch)
(set-face-attribute 'org-code nil :inherit '(shadow fixed-pitch))
(set-face-attribute 'org-indent nil :inherit '(org-hide fixed-pitch))
(set-face-attribute 'org-special-keyword nil :inherit '(font-lock-comment-face fixed-pitch))
(set-face-attribute 'org-meta-line nil :inherit '(font-lock-comment-face fixed-pitch))

(custom-theme-set-faces
 'user
  `(org-document-info-keyword ((t :foreground "#9F9F9F")))

  `(org-level-1 ((t :foreground "#2a2a2a" :weight bold)))
  `(org-level-2 ((t :foreground "#2a2a2a" :weight bold)))
  `(org-level-3 ((t :foreground "#2a2a2a" :weight normal)))
  `(org-level-4 ((t :foreground "#2a2a2a" :weight normal)))
  `(org-level-5 ((t :foreground "#2a2a2a" :weight normal)))
  `(org-level-6 ((t :foreground "#2a2a2a" :weight normal)))
  `(org-level-7 ((t :foreground "#2a2a2a" :weight normal)))
  `(org-level-8 ((t :foreground "#2a2a2a" :weight normal)))
  `(org-level-9 ((t :foreground "#2a2a2a" :weight normal)))

  `(org-block            ((t :inherit 'fixed-pitch)))
  `(org-block-begin-line ((t :foreground "#BF9B9F" :background nil :underline "#2A2A2A")))
  `(org-block-end-line   ((t :foreground "#BF9B9F" :background nil :underline nil :overline "#2A2A2A")))
  `(org-verbatim         ((t :foreground "#BE3445" :background nil :weight normal)))

  `(org-table            ((t :background "#FBF7EF")))
  `(org-formula          ((t :background "#FBF7EF")))
  `(org-ref-cite-face    ((t :foreground "#BE3445")))
  `(org-drawer           ((t :foreground "#9F9F9F")))

  `(ivy-current-match    ((t :foreground "#2A2A2A"))))

(set-frame-parameter (selected-frame) 'alpha '(85 85))
(add-to-list 'default-frame-alist '(alpha 85 85))


