(defun testen () 
  (and (not (equal #\q (read-char)))
       (format t "hallo~%")))
