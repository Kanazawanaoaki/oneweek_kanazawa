(load "potato-new-type.l")
(setq *potato* (potato))
(send *potato* :cut)


(objects (list *potato*))

(send p1 :dissoc p7)
(send p7 :translate #f(-20 0 0) :world)
(send *viewer* :draw-objects) 

(send p1 :set-color :moccasin)
(send p2 :set-color :moccasin)
(send p3 :set-color :moccasin)
(send p4 :set-color :moccasin)
(send p5 :set-color :moccasin)
(send p6 :set-color :moccasin)
