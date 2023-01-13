(defun test (&key (text `(print "test")))
  ;; (format t "now text is ~A ~%" text)
  (format t "> ~A ~%" text)
  (eval text)
  nil)

(defun hello (&key (text "hello world"))
  (print text)
  nil)


(defun load-test (&key (file-name "test-func.txt"))
  (with-open-file
   (f file-name :direction :input)
   (setq text (read f))
   )
  (test :text text)
 )

(defun load-file-test (&key (file-name "test-func.txt"))
  (with-open-file (s file-name :direction :input)
                  (while (setq b (read s nil))
                    ;; (print b)
                    (test :text b)
                    ))
  )


(defun load-test-simple (&key (file-name "test-func.txt"))
  (load file-name)
  )

(test)
