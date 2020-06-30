(load "../../model/onion-test-model.l")
(setq *onion* (onion))


(send *onion* :locate #f(50 0 100))
(send *onion* :wedges)

(objects (list *onion*))

(send o3-1 :dissoc o4-1)
(send o4-1 :translate #f(0 -10 0))
(send o4-1 :dissoc o2-1)
(send o2-1 :translate #f(0 0 60))
(send o4-1 :dissoc o6-1)
(send o6-1 :translate #f(0 0 -60))

(send o3-1 :dissoc o1-1)
(send o1-1 :translate #f(0 0 60))
(send o3-1 :dissoc o5-1)
(send o5-1 :translate #f(0 0 -60))

(send o3-1 :dissoc o3-2)
(send o3-2 :translate #f(0 60 0))
(send o4-1 :dissoc o4-2)
(send o4-2 :translate #f(0 -60 0))

;; cut part visulaization
(setq *o-list-3* (list o3-3-1 o3-3-2 o3-3-3 o3-1))
(setq *o-list-4* (list o4-3-1 o4-3-2 o4-3-3 o4-1))

(send o3-1 :dissoc o3-3-1)
(send o3-1 :dissoc o3-3-2)
(send o3-1 :dissoc o3-3-3)
(send o4-1 :dissoc o4-3-1)
(send o4-1 :dissoc o4-3-2)
(send o4-1 :dissoc o4-3-3)

(setq leng (length *o-list-3*))
(dolist (x *o-list-3*)
  (send x :translate (float-vector (* leng 10) 10 0) :world)
  (setq leng (- leng 1))
  )

(setq leng (length *o-list-4*))
(dolist (x *o-list-4*)
  (send x :translate (float-vector (* leng 10) -10 0) :world)
  (setq leng (- leng 1))
  )

(send *viewer* :draw-objects)
