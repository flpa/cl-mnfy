(in-package #:cl-mnfy)

(defun print-code (code) 
  (loop 
    initially (format t "(")
    for prev = nil then sym
    for sym in code
    do (if (listp sym)
         (print-code sym)
         (format t "~:[~; ~]~:s" (and (not (listp prev))
                                      (not (listp sym))) sym))
    finally (format t ")"))) 

(defun minify (filename)
  (print-code (with-open-file (in filename)
                (read in))))

;;(minify "res/test.lisp")
