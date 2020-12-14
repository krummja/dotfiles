(defgroup doom-sakura-dark-theme nil
  "Options for doom themes."
  :group 'doom-themes)

(def-doom-theme doom-sakura-dark
  "A soothing dark theme, tranquil as a spring breeze."

  ;; name           default     256          16
  ( (bg           '("#2A2A2A"   "#FBF7EF"    nil))
    (bg-alt       '("#2A2A2A"   "#FBF7EF"    nil))
    (base0        '("#E2D8F5"   "#363636"   "black"))
    (base1        '("#E7CEEE"   "#414141"   nil))
    (base2        '("#C9678D"   "#BF9B9F"   nil))
    (base3        '("#ECA7D5"   "#EBE6EA"   nil)) ;; block highlights
    (base4        '("#C9678D"   "#C9678D"   nil))
    (base5        '("#EBE6EA"   "#ECA7D5"   nil))
    (base6        '("#BF9B9F"   "#C9678D"   nil))
    (base7        '("#414141"   "#E7CEEE"   nil))
    (base8        '("#363636"   "#E2D8F5"   nil))
    (fg           '("#FBF7EF"   "#2A2A2A"   nil))
    (fg-alt       '("#FBF7EF"   "#2A2A2A"   nil))

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
    (cursor-color       '("#FFFFFF"))
    (+evil--default-cursor-color '("#FFFFFF"))
    (modeline-fg        nil)))
