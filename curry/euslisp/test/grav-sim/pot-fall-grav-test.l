(defun grav-sim-func (abody floor)
  (setq t-flag nil)
  (until t-flag
	 (send abody :translate #f(0 0 -1) :world)
	 (send *viewer* :draw-objects)	 
	 (if (= (pqp-collision-check abody floor) 1)
	     (setq t-flag t))
	 )
  )


(load "../../model/pot-update-model.l")
(load "../../model/potato-test-model.")
(setq *potato* (potato))
(send *potato* :cut)

(send *potato* :translate #f(0 150 150))

(send p4 :dissoc p1)
(send p4 :dissoc p2)
(send p4 :dissoc p3)
(send p4 :dissoc p5)
(send p4 :dissoc p6)

(send p1 :move-to (make-coords :pos #f(0 0 200)) :world)
(send p1 :rotate (deg2rad 60) :x :world)

(setq *pot* (cooking-pot))


(objects (list p1 *pot*))
(send *viewer* :draw-objects)


(grav-sim-func p1 *pot*)
