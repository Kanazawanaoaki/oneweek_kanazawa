(load "models/arrow-object.l")
(setq *arrow* (arrow))

(format t "~% out of func ~%")
(setq *hoge*  #f(0.0 -1.0 0.0))
(format t "hoge: ~A hoge address: ~A ~%"  *hoge* (sys::address *hoge*))
(send *arrow* :newcoords (make-coords :pos *hoge*))
(send *arrow* :translate #f(0 0 10) :world)
(format t "hoge: ~A hoge address: ~A ~%"  *hoge* (sys::address *hoge*))

(setq *hoge*  #f(0.0 -1.0 0.0))
(format t "hoge: ~A hoge address: ~A ~%"  *hoge* (sys::address *hoge*))
(send *arrow* :newcoords (make-coords :pos *hoge*))
(send *arrow* :translate #f(0 0 10) :world)
(format t "hoge: ~A hoge address: ~A ~%"  *hoge* (sys::address *hoge*))


(defun hoge ()
  (setq *hoge*  #f(0.0 -1.0 0.0))
  (format t "hoge: ~A hoge address: ~A ~%"  *hoge* (sys::address *hoge*))
  (send *arrow* :newcoords (make-coords :pos *hoge*))
  (send *arrow* :translate #f(0 0 10) :world)
  (format t "hoge: ~A hoge address: ~A ~%"  *hoge* (sys::address *hoge*))
  )

(format t "~% from inside of func ~%")
(hoge)
(hoge)

