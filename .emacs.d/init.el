(setq inhibit-startup-message t)
(setq visible-bell t)
(setq-default fill-column 80)

(scroll-bar-mode -1)
(tool-bar-mode -1)
(tooltip-mode -1)
(menu-bar-mode -1)

(set-fringe-mode 10)

(setq custom-file (concat user-emacs-directory "custom.el"))
(load custom-file 'noerror)

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

(use-package evil
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  (setq evil-want-C-u-scroll t)
  (setq evil-want-C-i-jump nil)
  (setq evil-respect-visual-line-mode t)
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
(global-display-line-numbers-mode t)
(dolist (mode '(org-mode-hook
		eshell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

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

(use-package ace-window
  :bind (("M-o" . ace-window))
  :config
  (setq aw-keys '(?h ?j ?k ?l)))

(sakura/leader-key-def 
  "w" '(:ignore t :which-key "windows")
  "w-" 'split-window-vertically
  "w/" 'split-window-horizontally
  "wd" 'delete-window
  "of" 'make-frame)

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

(defun sakura/org-mode-setup ()
  (org-indent-mode)
;  (variable-pitch-mode 1)
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
	org-startup-folded 'content
	org-cycle-separator-lines 2)

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
  (org-bullets-bullet-list '("-" "-" "-")))

(font-lock-add-keywords 'org-mode
                        '(("^ *\\([-]\\) "
			   (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "•"))))))

(require 'org-indent)
;; (setq org-hide-leading-stars t)
(set-face-attribute 'org-block nil :foreground nil :inherit 'fixed-pitch)
(set-face-attribute 'org-code nil :inherit '(shadow fixed-pitch))
(set-face-attribute 'org-indent nil :inherit '(org-hide fixed-pitch))
(set-face-attribute 'org-special-keyword nil :inherit '(font-lock-comment-face fixed-pitch))
(set-face-attribute 'org-meta-line nil :inherit '(font-lock-comment-face fixed-pitch))
(custom-theme-set-faces
 'user
  `(org-document-info-keyword ((t :foreground "#9F9F9F")))

  `(org-level-1 ((t :foreground "#BE3445" :weight bold)))
  `(org-level-2 ((t :foreground "#BE3445" :weight bold)))
  `(org-level-3 ((t :foreground "#BE3445" :weight normal)))
  `(org-level-4 ((t :foreground "#BE3445" :weight normal)))
  `(org-level-5 ((t :foreground "#BE3445" :weight normal)))
  `(org-level-6 ((t :foreground "#BE3445" :weight normal)))
  `(org-level-7 ((t :foreground "#BE3445" :weight normal)))
  `(org-level-8 ((t :foreground "#BE3445" :weight normal)))
  `(org-level-9 ((t :foreground "#BE3445" :weight normal)))

  `(org-block            ((t :inherit 'fixed-pitch)))
  `(org-block-begin-line ((t :foreground "#BF9B9F" :background nil :underline "#2A2A2A")))
  `(org-block-end-line   ((t :foreground "#BF9B9F"
			     :background nil
			     :underline nil
			     :overline "#2A2A2A")))
  `(org-verbatim         ((t :foreground "#BE3445" :background nil :weight normal)))

  `(org-table   ((t :background "#ebe6ea")))
  `(org-formula ((t :background "#ebe6ea")))
  `(org-ref-cite-face ((t :foreground "#BE3445")))
  `(org-drawer ((t :foreground "#9F9F9F"))))

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

(use-package doom-themes
  :config
  (setq doom-themes-enable-bold t
	doom-themes-enable-italic t)
  (load-theme 'doom-gruvbox t)
  (doom-themes-visual-bell-config))


