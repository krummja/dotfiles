clean:
	@rm -f init.elc emacs.el emacs.elc

compile: init.el sakura.org clean
	@emacs -Q --batch -l 'lisp/compile.el'
