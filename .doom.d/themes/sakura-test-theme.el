(deftheme sakura-test
  "Created 2020-06-27.")

(custom-theme-set-faces
 'sakura-test
 '(default ((t (:family "Fira Code" :foundry "CTDB" :width normal :height 98 :weight normal :slant normal :underline nil :overline nil :strike-through nil :box nil :inverse-video nil :foreground "#2A2A2A" :background "#FBF7EF" :stipple nil :inherit nil))))
 '(cursor ((t (:background "#ffffff"))))
 '(fixed-pitch ((t (:family "Monospace"))))
 '(variable-pitch ((((type w32)) (:foundry "outline" :family "Arial")) (t (:family "Sans Serif"))))
 '(escape-glyph ((((background dark)) (:foreground "cyan")) (((type pc)) (:foreground "magenta")) (t (:foreground "brown"))))
 '(homoglyph ((((background dark)) (:foreground "cyan")) (((type pc)) (:foreground "magenta")) (t (:foreground "brown"))))
 '(minibuffer-prompt ((((class color) (min-colors 257)) (:foreground "#6189b6")) (((class color) (min-colors 256)) (:foreground "#6189b6")) (((class color) (min-colors 16)) (:foreground "#6189b6"))))
 '(highlight ((((class color) (min-colors 257)) (:distant-foreground "#363636" :foreground "#E2D8F5" :background "#6189b6")) (((class color) (min-colors 256)) (:distant-foreground nil :foreground nil :background "#6189b6")) (((class color) (min-colors 16)) (:distant-foreground nil :foreground nil :background "#6189b6"))))
 '(region ((t (:background "#C9678D"))))
 '(shadow ((((class color) (min-colors 257)) (:foreground "#B48EAD")) (((class color) (min-colors 256)) (:foreground nil)) (((class color) (min-colors 16)) (:foreground nil))))
 '(secondary-selection ((((class color) (min-colors 257)) (:extend t :background "#4F4B4F")) (((class color) (min-colors 256)) (:extend t :background nil)) (((class color) (min-colors 16)) (:extend t :background nil))))
 '(trailing-whitespace ((((class color) (min-colors 257)) (:background "#BE3445")) (((class color) (min-colors 256)) (:background nil)) (((class color) (min-colors 16)) (:background nil))))
 '(font-lock-builtin-face ((((class color) (min-colors 257)) (:foreground "#29838D")) (((class color) (min-colors 256)) (:foreground nil)) (((class color) (min-colors 16)) (:foreground nil))))
 '(font-lock-comment-delimiter-face ((t (:inherit (font-lock-comment-face)))))
 '(font-lock-comment-face ((((class color) (min-colors 257)) (:foreground "#90718a")) (((class color) (min-colors 256)) (:foreground nil)) (((class color) (min-colors 16)) (:foreground nil))))
 '(font-lock-constant-face ((((class color) (min-colors 257)) (:foreground "#CE67CF")) (((class color) (min-colors 256)) (:foreground nil)) (((class color) (min-colors 16)) (:foreground nil))))
 '(font-lock-doc-face ((((class color) (min-colors 257)) (:foreground "#876a81" :inherit (font-lock-comment-face))) (((class color) (min-colors 256)) (:foreground nil :inherit (font-lock-comment-face))) (((class color) (min-colors 16)) (:foreground nil :inherit (font-lock-comment-face)))))
 '(font-lock-function-name-face ((((class color) (min-colors 257)) (:foreground "#29838D")) (((class color) (min-colors 256)) (:foreground nil)) (((class color) (min-colors 16)) (:foreground nil))))
 '(font-lock-keyword-face ((((class color) (min-colors 257)) (:foreground "#3B6EA8")) (((class color) (min-colors 256)) (:foreground nil)) (((class color) (min-colors 16)) (:foreground nil))))
 '(font-lock-negation-char-face ((((class color) (min-colors 257)) (:foreground "#3B6EA8" :inherit (bold))) (((class color) (min-colors 256)) (:foreground nil :inherit (bold))) (((class color) (min-colors 16)) (:foreground nil :inherit (bold)))))
 '(font-lock-preprocessor-face ((((class color) (min-colors 257)) (:foreground "#3B6EA8" :inherit (bold))) (((class color) (min-colors 256)) (:foreground nil :inherit (bold))) (((class color) (min-colors 16)) (:foreground nil :inherit (bold)))))
 '(font-lock-regexp-grouping-backslash ((((class color) (min-colors 257)) (:foreground "#3B6EA8" :inherit (bold))) (((class color) (min-colors 256)) (:foreground nil :inherit (bold))) (((class color) (min-colors 16)) (:foreground nil :inherit (bold)))))
 '(font-lock-regexp-grouping-construct ((((class color) (min-colors 257)) (:foreground "#3B6EA8" :inherit (bold))) (((class color) (min-colors 256)) (:foreground nil :inherit (bold))) (((class color) (min-colors 16)) (:foreground nil :inherit (bold)))))
 '(font-lock-string-face ((((class color) (min-colors 257)) (:foreground "#AAC275")) (((class color) (min-colors 256)) (:foreground nil)) (((class color) (min-colors 16)) (:foreground nil))))
 '(font-lock-type-face ((((class color) (min-colors 257)) (:foreground "#E1B967")) (((class color) (min-colors 256)) (:foreground nil)) (((class color) (min-colors 16)) (:foreground nil))))
 '(font-lock-variable-name-face ((((class color) (min-colors 257)) (:foreground "#842879")) (((class color) (min-colors 256)) (:foreground nil)) (((class color) (min-colors 16)) (:foreground nil))))
 '(font-lock-warning-face ((t (:inherit (warning)))))
 '(button ((t (:inherit (link)))))
 '(link ((((class color) (min-colors 257)) (:weight bold :underline (:color foreground-color :style line) :foreground "#6189b6")) (((class color) (min-colors 256)) (:weight bold :underline (:color foreground-color :style line) :foreground "#6189b6")) (((class color) (min-colors 16)) (:weight bold :underline (:color foreground-color :style line) :foreground "#6189b6"))))
 '(link-visited ((default (:inherit (link))) (((class color) (background light)) (:foreground "magenta4")) (((class color) (background dark)) (:foreground "violet"))))
 '(fringe ((((class color) (min-colors 257)) (:foreground "#C9678D" :inherit (default))) (((class color) (min-colors 256)) (:foreground nil :inherit (default))) (((class color) (min-colors 16)) (:foreground nil :inherit (default)))))
 '(header-line ((((class color) (min-colors 257)) (:distant-foreground "#FBF7EF" :foreground "#2A2A2A" :background "#FBF7EF")) (((class color) (min-colors 256)) (:distant-foreground nil :foreground nil :background nil)) (((class color) (min-colors 16)) (:distant-foreground nil :foreground nil :background nil))))
 '(tooltip ((((class color) (min-colors 257)) (:foreground "#2A2A2A" :background "#ECA7D5")) (((class color) (min-colors 256)) (:foreground nil :background nil)) (((class color) (min-colors 16)) (:foreground nil :background nil))))
 '(mode-line ((((class color) (min-colors 257)) (:distant-foreground "#FBF7EF" :foreground "#2A2A2A" :background "#FBF7EF")) (((class color) (min-colors 256)) (:distant-foreground nil :foreground nil :background nil)) (((class color) (min-colors 16)) (:distant-foreground nil :foreground nil :background nil))))
 '(mode-line-buffer-id ((t (:weight bold))))
 '(mode-line-emphasis ((((class color) (min-colors 257)) (:distant-foreground "#FBF7EF" :foreground "#6189b6")) (((class color) (min-colors 256)) (:distant-foreground nil :foreground "#6189b6")) (((class color) (min-colors 16)) (:distant-foreground nil :foreground "#6189b6"))))
 '(mode-line-highlight ((((class color) (min-colors 257)) (:distant-foreground "#FBF7EF" :inherit (highlight))) (((class color) (min-colors 256)) (:distant-foreground nil :inherit (highlight))) (((class color) (min-colors 16)) (:distant-foreground nil :inherit (highlight)))))
 '(mode-line-inactive ((((class color) (min-colors 257)) (:distant-foreground "#FBF7EF" :foreground "#2A2A2A" :background "#FBF7EF")) (((class color) (min-colors 256)) (:distant-foreground nil :foreground nil :background nil)) (((class color) (min-colors 16)) (:distant-foreground nil :foreground nil :background nil))))
 '(isearch ((t (:weight bold :inherit (lazy-highlight)))))
 '(isearch-fail ((((class color) (min-colors 257)) (:weight bold :foreground "#E2D8F5" :background "#BE3445")) (((class color) (min-colors 256)) (:weight bold :foreground nil :background nil)) (((class color) (min-colors 16)) (:weight bold :foreground nil :background nil))))
 '(lazy-highlight ((((class color) (min-colors 257)) (:weight bold :distant-foreground "#E2D8F5" :foreground "#363636" :background "#5272AF")) (((class color) (min-colors 256)) (:weight bold :distant-foreground nil :foreground nil :background nil)) (((class color) (min-colors 16)) (:weight bold :distant-foreground nil :foreground nil :background nil))))
 '(match ((((class color) (min-colors 257)) (:weight bold :background "#E2D8F5" :foreground "#AAC275")) (((class color) (min-colors 256)) (:weight bold :background nil :foreground nil)) (((class color) (min-colors 16)) (:weight bold :background nil :foreground nil))))
 '(next-error ((t (:inherit (region)))))
 '(query-replace ((t (:inherit (isearch))))))

(provide-theme 'sakura-test)
