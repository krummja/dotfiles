;;; -*- lexical-binding: t; -*-

;; (setq config-packages
;;   '(; ----------------------------- Unowned Packages ----------------------------- ;
;;     evil
;;     magit
;;     ; ------------------------------ Owned Packages ------------------------------ ;
;;     ; Owned packages are those that have a corresponding init-[package] here       ;
;;     deft
;;     doom-modeline
;;     doom-themes
;;     guide-key
;;     nov
;;     org-noter
;;     org-projectile
;;     org-ref
;;     org-roam
;;     pdfgrep
;;     pdf-tools
;;     zotxt))

;; (defun config/post-init-evil ())

;; (defun config/init-deft ()
;;   (use-package deft
;;     :init
;;     (setq deft-directory NOTEBOOK-PATH)
;;     (setq deft-recursive nil)
;;     (setq deft-extensions '("org" "md" "txt" "tex"))
;;     (setq deft-default-extension "org")
;;     (setq deft-use-filename-as-title t)
;;     (setq deft-use-filter-string-for-filename t)
;;     (setq deft-auto-save-interval 0))) 

;; (defun config/init-doom-modeline ()
;;   (use-package doom-modeline
;;     :init
;;     (setq doom-modeline-mode 1)
;;     (setq-default line-spacing 1)))

;; (defun config/init-doom-themes ()
;;   (use-package doom-themes
;;     :init
;;     (require 'doom-modeline)
;;     (setq doom-themes-enable-bold t)
;;     (setq doom-themes-enable italic t)
;;     (load-theme 'doom-Iosvkem t)))

;; (defun config/init-nov ()
;;   (use-package nov
;;     :init
;;     (add-to-list 'auto-mode-alist '("\\.epub\\'" . nov-mode))))

;; (defun config/init-org-noter ())
;; (defun config/init-org-ref ())
;; (defun config/init-org-roam ())
;; (defun config/init-pdfgrep ())
;; (defun config/init-pdf-tools ())
;; (defun config/init-zotxt ())