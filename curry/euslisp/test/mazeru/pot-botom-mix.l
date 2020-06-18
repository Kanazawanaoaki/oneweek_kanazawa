(defun bottom-mix-move (abody1 abody2)
  (let (box1 box2 bc m1 m2 mn target)
    (send abody1 :rotate (deg2rad (random 360)) :z :world)
    (send abody1 :copy-worldcoords)
    (setq box1 (make-bounding-box (send abody1 :vertices)))
    (setq bc (make-cascoords :pos (send box1 :center)))
    (setq m1 (v- (send box1 :maxpoint) (send box1 :minpoint)))
    (send bc :translate (float-vector 0 0 (/ (elt m1 2) -2.0)) :world)
    
    (send abody2 :copy-worldcoords)
    (setq box2 (make-bounding-box (send abody2 :vertices)))
    (setq m2 (v- (send box2 :maxpoint) (send box2 :minpoint)))
    (setq mn (v- m2 (float-vector (* (elt m1 0) 1.5) (* (elt m1 1) 1.5) 0))) ;; 余分に入れている。
    
    (if (send abody1 :parent) (send (send abody1 :parent) :dissoc abody1))
    (send bc :assoc abody1)
    
    (setq target (make-coords :pos (v+ (float-vector (random (elt mn 0)) (random (elt mn 1))  (random (elt mn 2)))  (v+ (send box2 :minpoint)  (float-vector (* (elt m1 0) 0.75) (* (elt m1 1) 0.75) 0)))))

    (send bc :move-to target :world))
    )

(defun list-pqp-check (abody o-list)
  (let (t-flag)
    (setq t-flag t)
    (dolist (x o-list)
      (if (= (pqp-collision-check abody x) 1)
	  (setq t-flag nil))) 
    t-flag))

(defun bottom-mix-test (container bottom bodies nakami)
  (let (c-flag pqp-list)
    (setq pqp-list (list container))
    (dolist (x bodies)
      (setq c-flag nil)
      (until c-flag
	     (bottom-mix-move x bottom)
	     (if (list-pqp-check x pqp-list)
		 (setq c-flag t))
	     ;; (if (= (pqp-collision-check x nakami) 0) ;;何故か上手く行かない
	     ;; 	 (setq c-flag nil))
	     )
      (push x pqp-list)
      )))


(defun bottom-mix (container bottom bodies)
  (let (c-flag pqp-list)
    (setq pqp-list (list container))
    (dolist (x bodies)
      (setq c-flag nil)
      (until c-flag
	     (bottom-mix-move x bottom)
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


(send *potato* :translate #f(0 0 150))
(send *potato* :cut)

(send *potato* :rotate (deg2rad -90) :y)

(send p4 :dissoc p1)
(send p4 :dissoc p2)
(send p4 :dissoc p3)

(send p4 :rotate (deg2rad 180) :y :world)
(send p4 :dissoc p5)
(send p4 :dissoc p6)

(setq *p-list* (list p1 p2 p3 p4 p5 p6))


(send *carrot* :translate #f(0 100 150))
(send *carrot* :cut)

(send c2-1-1 :dissoc c1)
(send c2-1-1 :dissoc c3-1-1)
(send c2-1-1 :dissoc c4)

(send c2-1-1 :translate #f(0 0 50) :world)

(send c2-1-1 :dissoc c2-2-1)

(send c2-1-1 :rotate (deg2rad -90) :x)
(send c2-1-1 :translate #f(0 50 0) :world)
(send c2-2-1 :rotate (deg2rad 90) :x)
(send c2-2-1 :translate #f(0 -50 0) :world)

(send c2-1-1 :dissoc c2-1-2)
(send c2-1-1 :dissoc c2-1-3)
(send c2-1-1 :dissoc c2-1-4)
(send c2-1-1 :dissoc c2-1-5)
(send c2-1-1 :dissoc c2-1-6)
(send c2-1-1 :dissoc c2-1-7)

(send c2-2-1 :dissoc c2-2-2)
(send c2-2-1 :dissoc c2-2-3)
(send c2-2-1 :dissoc c2-2-4)
(send c2-2-1 :dissoc c2-2-5)
(send c2-2-1 :dissoc c2-2-6)
(send c2-2-1 :dissoc c2-2-7)

(setq *c-list-1* (list c2-1-1 c2-1-2 c2-1-3 c2-1-4 c2-1-5 c2-1-6 c2-1-7))
(setq *c-list-2* (list c2-2-1 c2-2-2 c2-2-3 c2-2-4 c2-2-5 c2-2-6 c2-2-7))
(setq *c-list* (append *c-list-1* *c-list-2*))


(send *onion* :translate #f(0 -100 150))
(send *onion* :cut)


(setq *o-list-3* (list o3-3-1 o3-3-2 o3-3-3 o3-3-4 o3-3-5 o3-3-6 o3-3-7 o3-3-8))
(setq *o-list-4* (list o4-3-1 o4-3-2 o4-3-3 o4-3-4 o4-3-5 o4-3-6 o4-3-7 o4-3-8))
(setq *o-list* (append *o-list-3* *o-list-4*))


(dolist (x *o-list-3*)
  (send x :move-to (send *pot* :copy-worldcoords) :world)
  (send x :rotate (deg2rad 90) :x)
  )

(dolist (x *o-list-4*)
  (send x :move-to (send *pot* :copy-worldcoords) :world)
  (send x :rotate (deg2rad -90) :x)
  )


(send *potato* :copy-worldcoords)

(setq *hoge* (send *pot* :bottom))
(send *hoge* :translate #f(0 0 5) :world)


(setq *nakami* (send *pot* :content))

;; (bottom-mix-test *pot* *hoge* *p-list* *nakami*)
;; (bottom-mix-test *pot* *hoge* *c-list-1* *nakami*)
;; (bottom-mix-test *pot* *hoge* *c-list-2* *nakami*)


(bottom-mix *pot* *hoge* *p-list*)
(bottom-mix *pot* *hoge* *c-list-1*)
(bottom-mix *pot* *hoge* *c-list-2*)

(bottom-mix *pot* *hoge* *o-list-3*)
(bottom-mix *pot* *hoge* *o-list-4*)




(objects (list *pot* *hoge* *potato* *carrot* *onion* ))
;; (objects (list *pot* *potato*))
