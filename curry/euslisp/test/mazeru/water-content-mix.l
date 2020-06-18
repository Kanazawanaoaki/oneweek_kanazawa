(defun content-mix-move (abody1 abody2)
  (let (box1 box2 bc m1 m2 mn target)
    (send abody1 :move-to (make-coords :pos (send abody1 :worldpos) :rpy (float-vector (random 6.28) (random 6.28) (random 6.28)) ) :world)
    (send abody1 :copy-worldcoords)
    (setq box1 (make-bounding-box (send abody1 :vertices)))
    (setq bc (make-cascoords :pos (send box1 :center)))
    (setq m1 (v- (send box1 :maxpoint) (send box1 :minpoint)))
  
    (send abody2 :copy-worldcoords)
    (setq box2 (make-bounding-box (send abody2 :vertices)))
    (setq m2 (v- (send box2 :maxpoint) (send box2 :minpoint)))
    (setq mn (v- m2 m1))
    (setq mn (v+ mn (float-vector 0 0 (/ (elt m1 2) 2))));;上に少し余裕を
    
    (if (send abody1 :parent) (send (send abody1 :parent) :dissoc abody1))
    (send bc :assoc abody1)
  
    (setq target (make-coords :pos (v+ (float-vector (random (elt mn 0)) (random (elt mn 1))  (random (elt mn 2)))  (v+ (send box2 :minpoint)  (float-vector (/ (elt m1 0) 2) (/ (elt m1 1) 2) (/ (elt m1 2) 2))))))
    
    (send bc :move-to target :world))
  )

(defun list-pqp-check (abody o-list)
  (let (t-flag)
    (setq t-flag t)
    (dolist (x o-list)
      (if (= (pqp-collision-check abody x) 1)
	  (setq t-flag nil))) 
    t-flag))

(defun water-mix (container nakami bodies)
  (let (c-flag pqp-list)
    (setq pqp-list (list container))
    (dolist (x bodies)
      (setq c-flag nil)
      (until c-flag
	     (content-mix-move x nakami)
	     (if (list-pqp-check x pqp-list)
		 (setq c-flag t)))
      (push x pqp-list)
      )))


(load "pot.l")
(setq *pot* (cooking-pot))

(load "potato-hoge.l")
(setq *potato* (potato))

(load "carrot-hoge.l")
(setq *carrot* (carrot))

(load "onion-hoge.l")
(setq *onion* (onion))

(load "niku-hoge.l")
(setq *niku* (niku))

;; potato
(send *potato* :translate #f(0 0 150))
(send *potato* :cut)

(setq *p-list-1* (list p1 p2 p3))
(setq *p-list-2* (list p4 p5 p6))
(setq *p-list* (append *p-list-1* *p-list-2*))

;; carrot codes
(send *carrot* :translate #f(0 200 150))
(send *carrot* :cut)

(send c2-1-1 :dissoc c1)
(send c2-1-1 :dissoc c3-1-1)
(send c2-1-1 :dissoc c4)

(setq *c-list-1* (list c2-1-1 c2-1-2 c2-1-3 c2-1-4 c2-1-5 c2-1-6 c2-1-7))
(setq *c-list-2* (list c2-2-1 c2-2-2 c2-2-3 c2-2-4 c2-2-5 c2-2-6 c2-2-7))
(setq *c-list* (append *c-list-1* *c-list-2*))

;; onion codes
(send *onion* :translate #f(0 -200 150))
(send *onion* :cut)

(setq *o-list-3* (list o3-3-1 o3-3-2 o3-3-3 o3-3-4 o3-3-5 o3-3-6 o3-3-7 o3-3-8))
(setq *o-list-4* (list o4-3-1 o4-3-2 o4-3-3 o4-3-4 o4-3-5 o4-3-6 o4-3-7 o4-3-8))
(setq *o-list* (append *o-list-3* *o-list-4*))


;; niku codes
(send *niku* :translate #f(200 0 150))
(setq *n-list* (list n1 n2 n3 n4 n5 n6 n7 n8))

;; potato
(dolist (x *p-list-1*)
  (if (send x :parent) (send (send x :parent) :dissoc x))
  (send x :move-to (send *pot* :copy-worldcoords) :world)
  (send x :rotate (deg2rad -90) :y)
  )

(dolist (x *p-list-2*)
  (if (send x :parent) (send (send x :parent) :dissoc x))
  (send x :move-to (send *pot* :copy-worldcoords) :world)
  (send x :rotate (deg2rad 90) :y)
  )

;; onion
(dolist (x *o-list-3*)
  (if (send x :parent) (send (send x :parent) :dissoc x))
  (send x :move-to (send *pot* :copy-worldcoords) :world)
  (send x :rotate (deg2rad 90) :x)
  )

(dolist (x *o-list-4*)
  (if (send x :parent) (send (send x :parent) :dissoc x))  
  (send x :move-to (send *pot* :copy-worldcoords) :world)
  (send x :rotate (deg2rad -90) :x)
  )

;; carrot
(dolist (x *c-list-1*)
  (if (send x :parent) (send (send x :parent) :dissoc x))
  (send x :move-to (send *pot* :copy-worldcoords) :world)
  (send x :rotate (deg2rad -90) :x)
  )

(dolist (x *c-list-2*)
  (if (send x :parent) (send (send x :parent) :dissoc x))  
  (send x :move-to (send *pot* :copy-worldcoords) :world)
  (send x :rotate (deg2rad 90) :x)
  )

(dolist (x *n-list*)
  (if (send x :parent) (send (send x :parent) :dissoc x))
  (send x :move-to (send *pot* :copy-worldcoords) :world)
  )




(setq *nakami* (send *pot* :water :surface 60))
(send *nakami* :set-color :cyan 0.5)



(water-mix *pot* *nakami* *p-list*)

(water-mix *pot* *nakami* *c-list-1*)
(water-mix *pot* *nakami* *c-list-2*)

(water-mix *pot* *nakami* *o-list-3*)
(water-mix *pot* *nakami* *o-list-4*)

(water-mix *pot* *nakami* *n-list*)


(objects (list *pot* *potato* *niku* *carrot* *onion* *nakami*))

