(global-unset-key (kbd "C-z"))

;; TODO: Define F5 through F9! Those are left for the user :)

(spacemacs/declare-prefix "o" "Sakura")

(spacemacs/declare-prefix "on" "Sakura Notebook")
  (spacemacs/set-leader-keys "ond" 'deft)