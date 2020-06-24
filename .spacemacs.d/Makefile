clean:
	@rm -f init.elc sakura.el sakura.elc

compile: init.el sakura.org clean
	@emacs -Q --batch -l 'lisp/compile.el'
