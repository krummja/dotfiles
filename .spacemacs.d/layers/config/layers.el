;;; -*- lexical-binding: t; -*-

(configuration-layer/declare-layers 
  '(
    (auto-completion  
      :variables
      auto-completion-enable-snippets-in-popup t
      auto-completion-enable-sort-by-usage     t)
    bibtex
    emacs-lisp
    helm
    markdown
    org
    pandoc
  ))