(in-package #:cl-mnfy)

(defun print-code (sexp) 
  (loop 
    initially (format t "(")
    for prev = nil then sym
    for sym in sexp
    do (if (listp sym)
         (print-code sym)
         ;; print symbols with ~a to get 'ab' instead of '#:ab'
         ;; rest with ~s to get escape chars (e.g. '"hello"')
         (format t "~:[~; ~]~:[~s~;~a~]" (and (not (listp prev))
                                      (not (listp sym))) (symbolp sym) (mini sym)))
    finally (format t ")"))) 

(defun mini (sym)
  (if (minifiable-p sym)
    ;; must check if used: fboundp, or as symbol?
    (make-symbol (subseq (symbol-name sym) 0 1))
    sym))

(defun minify (filename)
  (setf *shortened-symbols* (make-hash-table :test #'equal))
  (print-code (with-open-file (in filename)
                (read in))))

(minify "~/code/lisp/cl-mnfy/res/test.lisp")
(minify "~/code/lisp/cl-mnfy/res/comment.lisp")
(minify "~/code/lisp/cl-mnfy/res/docstring.lisp")

(defun minifiable-p (x)
  (and x
       (symbolp x)
       (> (length (symbol-name x)) 1)
       (not (or (fboundp x)
                (eql t x)))))

(defparameter *shortened-symbols* nil)

;;TODO: unit test
(assert (equal '(abc) 
               (remove-if-not 
                 #'minifiable-p 
                 '(defun abc () 
                    (princ 1)
                    #\c
                    10
                    nil
                    t))))
