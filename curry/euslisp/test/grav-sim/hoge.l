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

(setq *floor* (make-cube 200 200 10))


(objects (list p1 *floor*))
(send *viewer* :draw-objects)

