(require 'doom-themes)

(defgroup doom-sakura-light-theme nil
  "Options for doom-themes"
  :group 'doom-themes)

(def-doom-theme doom-sakura-light
  "A pleasant light theme, soft as a cherry blossom."

  ;; name           default     256         16
  ( (bg           '("#FBF7EF"   "#FBF7EF"   "white"))
    (bg-alt       '("#FBF7EF"   "#FBF7EF"   "white"))
    (base0        '("#363636"   "#363636"   "black"))
    (base1        '("#414141"   "#414141"   nil))
    (base2        '("#BF9B9F"   "#BF9B9F"   nil))
    (base3        '("#ebe6ea"   "#EBE6EA"   nil)) ;; block highlights
    (base4        '("#C9678D"   "#C9678D"   nil))
    (base5        '("#ECA7D5"   "#ECA7D5"   nil))
    (base6        '("#C9678D"   "#C9678D"   nil))
    (base7        '("#E7CEEE"   "#E7CEEE"   nil))
    (base8        '("#E2D8F5"   "#E2D8F5"   nil))
    (fg           '("#2A2A2A"   "#2A2A2A"   nil))
    (fg-alt       '("#2A2A2A"   "#2A2A2A"   nil))

    (grey base6)
    (red          '("#BE3445"   "#BE3445"   nil))
    (orange       '("#D36745"   "#D36745"   nil))     
    (green        '("#768E42"   "#BE3445"   nil))
    (yellow       '("#C38913"   "#E1B967"   nil))
    (magenta      '("#CE67CF"   "#CE67CF"   nil))

    (teal         '("#29838D"   "#29838D"   nil))
    (blue         '("#3B6EA8"   "#3B6EA8"   nil))
    (dark-blue    '("#5272AF"   "#5272AF"   nil))
    (violet       '("#842879"   "#842879"   nil))
    (cyan         '("#398EAC"   "#398EAC"   nil))
    (dark-cyan    '("#2C7088"   "#2C7088"   nil))

    ;; face categories -- required for all themes
    (highlight          (doom-blend blue bg 0.8))
    (vertical-bar       (doom-darken bg 0.15))
    (selection          (doom-blend blue bg 0.5))
    (builtin            teal)
    (comments           (doom-darken base5 0.2))
    (doc-comments       (doom-darken base5 0.25))
    (constants          magenta)
    (functions          teal)
    (keywords           blue)
    (methods            teal)
    (operators          blue)
    (type               yellow)
    (strings            green)
    (variables          violet)
    (numbers            magenta)
    (region             base4)
    (error              red)
    (warning            yellow)
    (success            green)
    (vc-modified        orange)
    (vc-added           green)
    (vc-deleted         red)
    (hl-line            (doom-blend base6 bg 0.6))
    (cursor-color       '("#000000"))
    (+evil--default-cursor-color '("#000000"))
    (modeline-fg        nil)))

(defvar blink-cursor-colors (list  "#92c48f" "#6785c5" "#be369c" "#d9ca65")
  "On each blink the cursor will cycle to the next color in this list.")

(setq blink-cursor-count 0)
(defun blink-cursor-timer-function ()
  "Zarza wrote this cyberpunk variant of timer `blink-cursor-timer'. 
Warning: overwrites original version in `frame.el'.

This one changes the cursor color on each blink. Define colors in `blink-cursor-colors'."
  (when (not (internal-show-cursor-p))
    (when (>= blink-cursor-count (length blink-cursor-colors))
      (setq blink-cursor-count 0))
    (set-cursor-color (nth blink-cursor-count blink-cursor-colors))
    (setq blink-cursor-count (+ 1 blink-cursor-count))
    )
  (internal-show-cursor nil (not (internal-show-cursor-p))))
