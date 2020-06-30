(load "../../model/carrot-test-model.l")
(setq *carrot* (carrot))


(send *carrot* :locate #f(50 0 100))
(send *carrot* :random)

(objects (list *carrot*))


(setq *c-list-2* (list c2-1-1 c2-1-2 c2-1-3 c2-1-4 c2-1-5 c2-1-6 c2-1-7 c2-1-8))

(send c2-1-1 :dissoc c1)
(send c2-1-1 :dissoc c3-1-1)
(send c2-1-1 :translate #f(0 0 50) :world)
(send *viewer* :draw-objects)

(setq *tmp-list-3* (list c2-1-8 c2-1-7 c2-1-6 c2-1-5 c2-1-4 c2-1-3 c2-1-2))
(setq leng (length *tmp-list-3*))
(dolist (x *tmp-list-3*)
  (send c2-1-1 :dissoc x)
  (send x :translate (float-vector (* leng -15) 0 0) :world)
  (send c2-1-1 :rotate (deg2rad -90) :x :world)
  (setq leng (- leng 1))
  (send *viewer* :draw-objects)
  (unix:sleep 1)
  )


(send *viewer* :draw-objects)
