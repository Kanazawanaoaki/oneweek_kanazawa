(load "models/arrow-object.l")
(setq *arrow* (arrow))

(warn "please run (set1) ~%")

(defun set1 ()
  (send *arrow* :newcoords (make-coords :pos (float-vector 500.0 2000.0 1100) :rot #2f((0.0 -0.707107 0.707107) (1.0 0.0 0.0) (0.0 0.707107 0.707107))))

  (objects (list *arrow*))
  (send *viewer* :draw-objects)

  (format t "worldcoords: ~A arrow address: ~A rot address: ~A ~%" (send *arrow* :copy-worldcoords) (sys::address *arrow*) (sys::address (send *arrow* :rot)))
  )

(defun set2 ()
  (send *arrow* :newcoords (make-coords :pos (float-vector 500.0 2000.0 1100) :rot #2f((0.0 0.0 1.0) (1.0 0.0 0.0) (0.0 1.0 0.0))))

  (send *viewer* :draw-objects)

  (format t "worldcoords: ~A arrow address: ~A rot address: ~A ~%" (send *arrow* :copy-worldcoords) (sys::address *arrow*) (sys::address (send *arrow* :rot)))
  )
