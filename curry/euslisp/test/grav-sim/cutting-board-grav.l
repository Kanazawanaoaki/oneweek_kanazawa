(defun grav-sim-func (abody floor)
  (setq t-flag nil)
  (until t-flag
	 (send abody :translate #f(0 0 -1) :world)
	 (send *viewer* :draw-objects)	 
	 (if (= (pqp-collision-check abody floor) 1)
	     (setq t-flag t))
	 )
  )

(load "models/room73b2-kitchen-object.l")
(setq *kitchen* (room73b2-kitchen))
(send *kitchen* :locate #f(800 -200 0))
(send *kitchen* :rotate (deg2rad 180) :z :world)

 ;; set まな板
(load "../../model/cutting-board.l")
(setq *cutting-board* (cutting-board))
(send *cutting-board* :locate #f(650 0 825))


(objects (list *kitchen* *cutting-board*))


(grav-sim-func *cutting-board* *kitchen*)
