(defun move-test (abody1 abody2)
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
  
  (setq target (make-coords :pos (v+ (float-vector (random (elt mn 0)) (random (elt mn 1))  (random (elt mn 2)))  (v+ (send box2 :minpoint)  (float-vector (/ (elt m1 0) 2) (/ (elt m1 1) 2) (/ (elt m1 2) 2))) ) :rpy (float-vector (random 6.28) (random 6.28) (random 6.28) )) )

  (send bc :move-to target :world)
  )




(load "pot.l")
(setq *pot* (cooking-pot))

(load "potato-hoge.l")
(setq *potato* (potato))

(send *potato* :translate #f(0 0 150))
(send *potato* :cut)

(send p4 :dissoc p5)
(send p4 :dissoc p6)

(send *potato* :copy-worldcoords)


;; (setq *nakami* (send *pot* :content))
;; (send *nakami* :set-color :cyan 0.5)

(setq *nakami* (send *pot* :water))
(send *nakami* :set-color :cyan 0.5)


(setq c-flag nil)
(until c-flag
       (move-test p1 *nakami*)
       (if (= (pqp-collision-check p1 *pot*) 0)
	   (setq c-flag t)))
(setq c-flag nil)
(until c-flag
       (move-test p2 *nakami*)
       (if (and (= (pqp-collision-check p2 *pot*) 0) (= (pqp-collision-check p2 p1) 0))
	   (setq c-flag t)))
(setq c-flag nil)
(until c-flag
       (move-test p3 *nakami*)
       (if (and (= (pqp-collision-check p3 *pot*) 0) (= (pqp-collision-check p3 p2) 0) (= (pqp-collision-check p3 p1) 0))
	   (setq c-flag t)))       
(setq c-flag nil)
(until c-flag
       (move-test p4 *nakami*)
       (if (and (= (pqp-collision-check p4 *pot*) 0) (= (pqp-collision-check p4 p3) 0) (= (pqp-collision-check p4 p2) 0) (= (pqp-collision-check p4 p1) 0))
	   (setq c-flag t)))       
(setq c-flag nil)
(until c-flag
       (move-test p5 *nakami*)
       (if (and (= (pqp-collision-check p5 *pot*) 0) (= (pqp-collision-check p5 p4) 0) (= (pqp-collision-check p5 p3) 0) (= (pqp-collision-check p5 p2) 0) (= (pqp-collision-check p5 p1) 0))
	   (setq c-flag t)))
(setq c-flag nil)
(until c-flag
       (move-test p6 *nakami*)
       (if (and (= (pqp-collision-check p6 *pot*) 0) (= (pqp-collision-check p6 p5) 0) (= (pqp-collision-check p6 p4) 0) (= (pqp-collision-check p6 p3) 0) (= (pqp-collision-check p6 p2) 0) (= (pqp-collision-check p6 p1) 0))
	   (setq c-flag t)))

;; (objects (list *pot* *potato* *nakami*))
(objects (list *pot* *nakami* *potato*))

