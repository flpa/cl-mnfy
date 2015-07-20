# cl-mnfy
Drafts for a Common Lisp minification tool.

## Vision
Being able to convert well documented and formatted Common Lisp code with proper variable/function names into a minimalistic representation suitable for [code golf](http://codegolf.stackexchange.com) challenges (for example). 

## Status
I'm still in an early test/prototype/experimentation phase. Some basic functionality is working, though.
Minifying this code:

    (defun flpa () 
      (and (not (equal #\q (read-char)))
           (format t "hallo~%")))

prints the following output:

    (DEFUN F()(AND(NOT(EQUAL #\q(READ-CHAR)))(FORMAT T "hallo~%")))

## License
MIT License
