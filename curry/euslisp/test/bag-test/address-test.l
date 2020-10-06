(format t "~% out of func ~%")
(setq *hoge*  #2f((0.0 -1.0 0.0) (1.0 0.0 0.0) (0.0 0.0 1.0)))
(print (sys::address *hoge*))
(setq *hoge*  #2f((0.0 -1.0 0.0) (1.0 0.0 0.0) (0.0 0.0 1.0)))
(print (sys::address *hoge*))


(defun hoge ()
  (setq *hoge*  #2f((0.0 -1.0 0.0) (1.0 0.0 0.0) (0.0 0.0 1.0)))
  (print (sys::address *hoge*))
  )

(format t "~% from inside of func ~%")
(hoge)
(hoge)

