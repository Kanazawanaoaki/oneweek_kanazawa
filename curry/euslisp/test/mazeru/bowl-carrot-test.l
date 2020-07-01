(defun grav-sim-func (abody floor)
  (setq t-flag nil)
  (until t-flag
	 (send abody :translate #f(0 0 -1) :world)
	 ;; (send *viewer* :draw-objects)	 
	 (if (= (pqp-collision-check abody floor) 1)
	     (setq t-flag t))
	 )
  )

;; add fot mix code
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
    (setq mn (v- m2 (float-vector (* (elt m1 0) 1.5) (* (elt m1 1) 1.5) (* (elt m1 2) 0.5)) ));;上に少し余裕を
    
    (if (send abody1 :parent) (send (send abody1 :parent) :dissoc abody1))
    (send bc :assoc abody1)
  
    (setq target (make-coords :pos (v+ (float-vector (random (elt mn 0)) (random (elt mn 1))  (random (elt mn 2)))  (v+ (send box2 :minpoint)  (float-vector (* (elt m1 0) 0.75) (* (elt m1 1) 0.75) (* (elt m1 2) 0.5))))))
    
    (send bc :move-to target :world))
  )

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


(load "../../model/bowl-update-model.l")
(setq *bowl* (bowl))


(load "../../model/carrot-test-model.l")
(setq *carrot* (carrot))
(send *carrot* :translate #f(0 100 0) :world)


(objects (list *carrot* *bowl*))


(warn "please run (carrot-cut) or (carrot-random) ~%")

(defun carrot-cut ()
  (send *carrot* :cut)
  (setq *c-list-1* (list c2-1-1 c2-1-2 c2-1-3 c2-1-4 c2-1-5 c2-1-6 c2-1-7))
  (setq *c-list-2* (list c2-2-1 c2-2-2 c2-2-3 c2-2-4 c2-2-5 c2-2-6 c2-2-7))
  (setq *c-list* (append *c-list-1* *c-list-2*))

  (send c2-1-1 :dissoc c1)
  (send c2-1-1 :dissoc c3-1-1)

  (objects (list *carrot* *bowl*))

  (setq *bowl-surface* (send *bowl* :content))

  (setq *pot-list* (list))
  (push *c-list-1* *pot-list*)
  (push *c-list-2* *pot-list*)
  
  (if (not (null *pot-list*))
      (dolist (x *pot-list*)
	(water-mix *bowl* *bowl-surface* x)))

  (dolist (x *c-list-1*)
    (grav-sim-func x *bowl*))
  
  (dolist (x *c-list-2*)
    (grav-sim-func x *bowl*))

  (send *viewer* :draw-objects)
  )

(defun carrot-random ()
  (send *carrot* :random)
  (setq *c-list-1* (list c2-1-1 c2-1-2 c2-1-3 c2-1-4))
  (setq *c-list-2* (list c2-1-5 c2-1-6 c2-1-7 c2-1-8))
  (setq *c-list* (append *c-list-1* *c-list-2*))

  (send c2-1-1 :dissoc c1)
  (send c2-1-1 :dissoc c3-1-1)

  (objects (list *carrot* *bowl*))
  (setq *bowl-surface* (send *bowl* :content))

  (setq *pot-list* (list))
  (push *c-list-1* *pot-list*)
  (push *c-list-2* *pot-list*)
  
  (if (not (null *pot-list*))
      (dolist (x *pot-list*)
	(water-mix *bowl* *bowl-surface* x)))

  (dolist (x *c-list-1*)
    (grav-sim-func x *bowl*))
  
  (dolist (x *c-list-2*)
    (grav-sim-func x *bowl*))

  (send *viewer* :draw-objects)
  )


