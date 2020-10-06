(load "models/arrow-object.l")
(setq *arrow* (arrow))

(format t "~% out of func ~%")
(setq *hoge*  #2f((0.0 -1.0 0.0) (1.0 0.0 0.0) (0.0 0.0 1.0)))
(format t "hoge: ~A hoge address: ~A ~%"  *hoge* (sys::address *hoge*))
(send *arrow* :newcoords (make-coords :pos (float-vector 500.0 2000.0 1100) :rot *hoge*))
(send *arrow* :rotate (deg2rad 45) :y :world)
(format t "hoge: ~A hoge address: ~A ~%"  *hoge* (sys::address *hoge*))

(setq *hoge*  #2f((0.0 -1.0 0.0) (1.0 0.0 0.0) (0.0 0.0 1.0)))
(format t "hoge: ~A hoge address: ~A ~%"  *hoge* (sys::address *hoge*))
(send *arrow* :newcoords (make-coords :pos (float-vector 500.0 2000.0 1100) :rot *hoge*))
(send *arrow* :rotate (deg2rad 45) :y :world)
(format t "hoge: ~A hoge address: ~A ~%"  *hoge* (sys::address *hoge*))


(defun hoge ()
  (setq *hoge*  #2f((0.0 -1.0 0.0) (1.0 0.0 0.0) (0.0 0.0 1.0)))
  (format t "hoge: ~A hoge address: ~A ~%"  *hoge* (sys::address *hoge*))
  (send *arrow* :newcoords (make-coords :pos (float-vector 500.0 2000.0 1100) :rot *hoge*))
  (send *arrow* :rotate (deg2rad 45) :y :world)
  (format t "hoge: ~A hoge address: ~A ~%"  *hoge* (sys::address *hoge*))
  )

(format t "~% from inside of func ~%")
(hoge)
(hoge)

