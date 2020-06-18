(defun move-test (abody1 abody2)
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
	     (move-test x nakami)
	     (if (list-pqp-check x pqp-list)
		 (setq c-flag t)))
      (push x pqp-list)
      )))


(load "pot.l")
(setq *pot* (cooking-pot))

(load "potato-hoge.l")
(setq *potato* (potato))

(send *potato* :translate #f(0 0 150))
(send *potato* :cut)

(send p4 :dissoc p5)
(send p4 :dissoc p6)

(send *potato* :copy-worldcoords)
(setq *p-list* (list p1 p2 p3 p4 p5 p6))


;; (setq *nakami* (send *pot* :content))
;; (send *nakami* :set-color :cyan 0.5)

(setq *nakami* (send *pot* :water))
(send *nakami* :set-color :cyan 0.5)



(water-mix *pot* *nakami* *p-list*)



(objects (list *pot* *potato* *nakami*))
;; (objects (list *pot* *nakami* *potato*))

