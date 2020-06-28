;;; ~/.doom.d/themes/sakura.el -*- no-byte-compile: t; -*-

(require 'doom-themes)

;;
(defgroup doom-sakura-light-theme nil
  "Options for doom-themes"
  :group  'doom-themes)

(defcustom doom-sakura-light-brighter-modeline nil
  "If non-nil, more vivid colors will be used to style the mode-line."
  :group  'doom-sakura-light-theme
  :type   'boolean)

(defcustom doom-sakura-light-brighter-comments nil
  "If non-nil, comments will be highlighted in more vivid colors."
  :group  'doom-sakura-light-theme
  :type   'boolean)

(defcustom doom-sakura-light-comment-bg doom-sakura-light-brighter-comments
  "If non-nil, comments will have a subtle, darker background, enchancing legibility."
  :group  'doom-sakura-light-theme
  :type   'boolean)

(defcustom doom-sakura-light-padded-modeline doom-themes-padded-modeline
  "If non-nil, adds a 4px padding to the mode-line. Can beinteger to determine exact padding."
  :group  'doom-sakura-light-theme
  :type   '(choice integer boolean))

;;
(def-doom-theme doom-sakura-light
  "A pleasant light theme."


  ;; name           default     256   16
  ( (bg           '("#FBF7EF"   nil   nil))
    (bg-alt       '("#FBF7EF"   nil   nil))
    (base0        '("#E2D8F5"   nil   nil))
    (base1        '("#E7CEEE"   nil   nil))
    (base2        '("#DDB3D8"   nil   nil))
    (base3        '("#ECA7D5"   nil   nil))
    (base4        '("#C9678D"   nil   nil))
    (base5        '("#B48EAD"   nil   nil))
    (base6        '("#4F4B4F"   nil   nil))
    (base7        '("#414141"   nil   nil))
    (base8        '("#363636"   nil   nil))
    (fg           '("#2A2A2A"   nil   nil))
    (fg-alt       '("#2A2A2A"   nil   nil))
   
    (grey base6)
    (red          '("#BE3445"   nil   nil))
    (orange       '("#D36745"   nil   nil))
    (green        '("#AAC275"   nil   nil))
    (yellow       '("#E1B967"   nil   nil)) 
    (magenta      '("#CE67CF"   nil   nil))
  
    (teal         '("#29838D"   nil   nil))
    (blue         '("#3B6EA8"   nil   nil))
    (dark-blue    '("#5272AF"   nil   nil))
    (violet       '("#842879"   nil   nil))
    (cyan         '("#398EAC"   nil   nil))
    (dark-cyan    '("#2C7088"   nil   nil))

    ;; face categories -- required for all themes
    (highlight (doom-blend blue bg 0.8))
    (vertical-bar (doom-darken bg 0.15))
    (selection (doom-blend blue bg 0.5))
    (builtin teal)
    (comments (if doom-sakura-light-brighter-comments dark-cyan (doom-darken base5 0.2)))
    (doc-comments (doom-darken (if doom-sakura-light-brighter-comments dark-cyan base5) 0.25))
    (constants magenta)
    (functions teal)
    (keywords blue)
    (methods teal)
    (operators blue)
    (type yellow)
    (strings green)
    (variables violet)
    (numbers magenta)
    (region base4)
    (error red)
    (warning yellow)
    (success green)
    (vc-modified orange)
    (vc-added green)
    (vc-deleted red)
    (cursor-color '("#000000"))
    (+evil--default-cursor-color '("#000000"))

    (modeline-fg nil)
;    (modeline-fg-alt (doom-blend violet base4 (if -modeline-bright 0.5 0.2)))

;    (modeline-bg
;      (if -modeline-bright
;        (doom-darken bg 0.475)
;        `(,(doom-darken (car bg) 0.15) ,@(cdr base0))))
;    (modeline-bg-1
;      (if -modeline-bright
;        (doom-darken blue 0.45)
;        `(,(doom-darken (car bg-alt) 0.1) ,@(cdr base1))))
  ))
