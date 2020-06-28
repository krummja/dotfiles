;;; ~/.doom.d/bindings.el -*- lexical-binding: t; -*-

(map!
 (:leader
  (:desc "Roam" :prefix "r"
    :desc "Begin Roaming"   :n "r"    (lambda () (interactive) (org-roam-mode) (org-roam-buffer-activate))
    :desc "Insert..."       :n "i"    #'org-roam-insert
    :desc "Store"           :n "s"    #'org-roam-store-link
    :desc "Index"           :n "h"    #'org-roam-jump-to-index)
  (:desc "Direx" :prefix "d"
   :desc "Open"            :n "d"    #'direx:jump-to-directory-other-window)))
