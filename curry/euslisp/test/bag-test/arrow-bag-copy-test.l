(load "models/arrow-object.l")
(setq *arrow* (arrow))

(warn "please run (set1) ~%")

(defun set1 ()
  (send *arrow* :newcoords (send (make-coords :pos (float-vector 500.0 2000.0 1100) :rot #2f((0.0 -1.0 0.0) (1.0 0.0 0.0) (0.0 0.0 1.0))) :copy-worldcoords))
  (send *arrow* :rotate (deg2rad 45) :y :world)

  (objects (list *arrow*))
  (send *viewer* :draw-objects)

  (format t "worldcoords: ~A arrow address: ~A rot address: ~A ~%" (send *arrow* :copy-worldcoords) (sys::address *arrow*) (sys::address (send *arrow* :rot)))
  )

(defun set2 ()
  (send *arrow* :newcoords (send (make-coords :pos (float-vector 500.0 2000.0 1100) :rot #2f((0.0 -1.0 0.0) (1.0 0.0 0.0) (0.0 0.0 1.0))) :copy-worldcoords))
  (send *arrow* :rotate (deg2rad 90) :y :world)

  (send *viewer* :draw-objects)

  (format t "worldcoords: ~A arrow address: ~A rot address: ~A ~%" (send *arrow* :copy-worldcoords) (sys::address *arrow*) (sys::address (send *arrow* :rot)))
  )

