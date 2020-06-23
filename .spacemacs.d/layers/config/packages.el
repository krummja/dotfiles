;;; -*- lexical-binding: t; -*-

(setq config-packages
  '(; ----------------------------- Unowned Packages ----------------------------- ;
    evil
    ; ------------------------------ Owned Packages ------------------------------ ;
    ; Owned packages are those that have a corresponding init-[package] here       ;
    deft
    doom-modeline
    doom-themes
    guide-key
    magit
    org-noter
    org-projectile
    org-ref
    org-roam
    pdfgrep
    pdf-tools
    zotxt))

(defun config/post-init-evil ())

(defun config/init-deft ())
(defun config/init-doom-modeline ())
(defun config/init-doom-themes ())
(defun config/init-magit ())
(defun config/init-org-noter ())
(defun config/init-org-ref ())
(defun config/init-org-roam ())
(defun config/init-pdfgrep ())
(defun config/init-pdf-tools ())
(defun config/init-zotxt ())