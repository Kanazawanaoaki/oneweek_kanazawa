(load "potato-new-type.l")
(setq *potato* (potato))
(send *potato* :cut)


(objects (list *potato*))

(send p4 :dissoc p7)
(send p7 :translate #f(20 0 0) :world)
(send *viewer* :draw-objects) 

(send p1 :set-color :moccasin)
(send p2 :set-color :moccasin)
(send p3 :set-color :moccasin)
(send p4 :set-color :moccasin)
(send p5 :set-color :moccasin)
(send p6 :set-color :moccasin)

;; p1 p2 p3 cut
(send p4 :dissoc p1)
(send p4 :dissoc p2)
(send p4 :dissoc p3)

(send p1 :assoc p2)
(send p1 :assoc p3)

(send p1 :translate #f(10 0 0) :world)
(send *viewer* :draw-objects) 


(send p1 :dissoc p2)
(send p1 :dissoc p3)

(send p3 :translate #f(0 0 -20) :world)
(send p2 :translate #f(0 0 -10) :world)


;; p4 p5 p6 cut
(send p4 :dissoc p5)
(send p4 :dissoc p6)

(send p6 :translate #f(0 0 -20))
(send p5 :translate #f(0 0 -10))


(load "models/arrow-object.l")
(setq *arrow* (arrow))

(send *arrow* :move-to (send *cut-point-2* :copy-worldcoords))
(objects (list *potato* *arrow*))
