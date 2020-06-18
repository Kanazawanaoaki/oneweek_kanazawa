;; def pot model
(defclass cooking-pot-object
  :super cascaded-link
  :slots (content
	  bottom
         ))

(defmethod cooking-pot-object
  (:init
   (&rest args &key (name "cooking-pot") (pos (float-vector 0 0 0)) (rot (unit-matrix 3)) &allow-other-keys)
   (let (link1 bc1 bc2)
     (send-super* :init :name name args)

     ;; definition of link
     (setq bc1 (make-solid-of-revolution (list #f(0 0 10) #f(100 0 10) #f( 120 0 110) #f(130 0 110) #f(110 0 5) #f(105 0 0) #f(0 0 0))))  
     (send bc1 :locate #f(0 0 5))
     (send bc1 :set-color :red)

     (setq bc2 (make-solid-of-revolution (list #f(0 0 110) #f(120 0 110) #f(100 0 10) #f(0 0 10))))
     (setq content bc2)
     (send bc1 :assoc content)

     (setq bc3 (make-solid-of-revolution (list #f(0 0 10) #f(100 0 10) #f(100 0 0) #f(0 0 0))))
     (setq bottom bc3)
     (send bc1 :assoc bottom)  

     (setq link1 (instance bodyset-link :init (make-cascoords) :bodies (list bc1) :weight 1 :centroid (float-vector 0.0 0.0 0.0) :inertia-tensor #2f((1.0 0.0 0.0) (0.0 1.0 0.0) (0.0 0.0 1.0))))


     ;; definition of assoc
     (send self :assoc link1)

     ;; definition of end-coords

     ;; definition of joint

     ;; definition of :handle

     ;; init-ending 
     (setq links (list link1))
     (send self :init-ending)
     (send self :move-to (make-coords :pos pos :rot rot))
     (send-all links :worldcoords)

     self))

  (:content (&rest args) (forward-message-to content args))
  (:bottom (&rest args) (forward-message-to bottom args))

  (:water
   (&rest args &key (surface 70))
   (let (bc1 b)
     (setq bc1 content)
     (setq b (make-bounding-box (send bc1 :vertices)))
     (setq m (v- (send b :maxpoint) (send b :minpoint)))
     (setq box (make-cube (* (elt m 0) 2) (* (elt m 1) 2) (* (elt m 2) 2)))
     (send box :locate (send b :center))

     (send box :locate (float-vector 0 0 (/ (elt m 2) 2)))
     (send box :locate (float-vector 0 0 surface))
     (setq bc1 (body- bc1 box))
     ))

  
  )

(defun cooking-pot (&rest args) (instance* cooking-pot-object :init args))


;; def potato model
(defun point-mul (point x y z)
  (float-vector (* (elt point 0) x) (* (elt point 1) y) (* (elt point 2) z)))

(defun make-ellipsoid (width length height)
  (setq x-scale (/ (float width) (float height)))
  (setq y-scale (/ (float length) (float height)))
  (setq b1 (make-sphere (/ height 2)))
  (setq v-list (list (point-mul (car (send b1 :vertices)) x-scale y-scale 1)))
  (dolist (x (cdr (send b1 :vertices))) (setq v-list (append v-list (list (point-mul x x-scale y-scale 1)))))
  (setq b2 (convex-hull-3d v-list))
  )

(defclass potato-object
  :super bodyset-link
  :slots (width
	  length
	  height
	  ))

(defmethod potato-object
  (:init
   (&rest args &key (w 90) (l 60) (h 60) &allow-other-keys)
   (let (b)
     (setq width w)
     (setq length l)
     (setq height h)
     (setq b (make-ellipsoid w l h))
     (send b :set-color :saddlebrown)
     (send-super* :init (make-cascoords) :bodies (list b) args)))
  (:print-info
   ()
   (format t "width ~A, length ~A, height ~A~%" width length height))
  (:change-color
   ()
   (let (b r)
     (setq b (make-ellipsoid width length height))
     (send b :newcoords (send self :copy-worldcoords))
     (send b :set-color :saddlebrown)
     (push b r)
     (setq geo::bodies r)))
  (:peel
   ()
   (let (b1 b2 b3 b4 r)
     (setq b1 (make-ellipsoid width length height))
     (setq b2 (make-cube (* 2 width) (* 2 length) (* 2 height)))
     (send b2 :locate (float-vector 0 (* (/ -2 3.0) length) 0))
   
     (setq b3 (make-cube (* 2 width) (* 2 length) (* 2 height)))
     (send b3 :locate (float-vector 0 (* (/ 2 3.0) length) 0))
   
     (setq b4 (make-cube (* 2 width) (* 2 length) (* 2 height)))
     (send b4 :locate (float-vector 0 0 (+ (* -1 height) 1)))
   
     (setq p2 (body- b1 b2))
     (setq b1 (body- b1 p2))
     (setq p4 (body- b1 b3))
     (setq b1 (body- b1 p4))
     (setq p1 (body- b1 b4))
     (setq p3 (body- b1 p1))
   
     (send p1 :assoc p2)
     (send p1 :assoc p3)
     (send p1 :assoc p4)

     (send p1 :set-color :saddlebrown)
     (send p2 :set-color :saddlebrown)
     (send p3 :set-color :saddlebrown)
     (send p4 :set-color :saddlebrown)
     (send p1 :newcoords (send self :copy-worldcoords))
     (send self :assoc p1)
     
     (push p1 r)
     (push p2 r)
     (push p3 r)
     (push p4 r)
     (setq geo::bodies r))
     )
  (:cut
   ()
   (let (b1 b2 b3 b4 b5 b6 r)
     (setq b1 (make-ellipsoid width length height))
     (setq b2 (make-cube (* 2 width) (* 2 length) (* 2 height)))
     (send b2 :locate (float-vector (+ (* -1 width) 1) 0 0))

     (setq b3 (body- b1 b2))
     (setq b4 (body- b1 b3))

     (setq b5 (make-cube (* 2 width) (* 2 length) (* 2 height)))
     (send b5 :locate (float-vector 0 0 (/ (* -5 height) 6)))
     (setq b6 (make-cube (* 2 width) (* 2 length) (* 2 height)))
     (send b6 :locate (float-vector 0 0 (/ (* -7 height) 6)))
     
     (setq p1 (body- b3 b5))
     (setq p4 (body- b4 b5))
     (setq b3 (body- b3 p1))
     (setq b4 (body- b4 p4))

     (setq p2 (body- b3 b6))
     (setq p5 (body- b4 b6))
     (setq p3 (body- b3 p2))
     (setq p6 (body- b4 p5))

     (send p1 :set-color :moccasin)
     (send p2 :set-color :moccasin)
     (send p3 :set-color :moccasin)
     (send p4 :set-color :moccasin)
     (send p5 :set-color :moccasin)
     (send p6 :set-color :moccasin)

     (send p4 :assoc p1)
     (send p4 :assoc p2)
     (send p4 :assoc p3)
     (send p4 :assoc p5)
     (send p4 :assoc p6)
     
     (setq *cut-point-1* (make-cascoords :pos (float-vector 0 0 (/ height -2))))
     (send *cut-point-1* :rotate (deg2rad 90) :z)
     (send p1 :assoc *cut-point-1*)

     (setq *cut-point-2* (make-cascoords :pos (float-vector 0 0 (/ height -6))))
     (send *cut-point-2* :rotate (deg2rad 90) :y)
     (send *cut-point-2* :rotate (deg2rad 90) :z)
     (send p2 :assoc *cut-point-2*)
     
     (setq *cut-point-3* (make-cascoords :pos (float-vector 0 0 (/ height 6))))
     (send *cut-point-3* :rotate (deg2rad 90) :y)
     (send *cut-point-3* :rotate (deg2rad 90) :z)
     (send p1 :assoc *cut-point-3*)

     (setq *cut-point-4* (make-cascoords :pos (float-vector 0 0 (/ height -6))))
     (send *cut-point-4* :rotate (deg2rad -90) :z)
     (send *cut-point-4* :rotate (deg2rad 90) :x)
     (send p5 :assoc *cut-point-4*)

     (setq *cut-point-5* (make-cascoords :pos (float-vector 0 0 (/ height 6))))
     (send *cut-point-5* :rotate (deg2rad -90) :z)
     (send *cut-point-5* :rotate (deg2rad 90) :x)
     (send p4 :assoc *cut-point-5*)

     (send p4 :newcoords (send self :copy-worldcoords))
     (send self :assoc p4)
     
     (push p1 r)
     (push p2 r)
     (push p3 r)
     (push p4 r)
     (push p5 r)
     (push p6 r)
     (setq geo::bodies r))
   )
  )

(defun potato (&rest args) (instance* potato-object :init args))


;; def rand mix func 
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
  
  ;; (setq target (make-coords :pos (v+ (float-vector (random (elt mn 0)) (random (elt mn 1))  (random (elt mn 2)))  (v+ (send box2 :minpoint)  (float-vector (/ (elt m1 0) 2) (/ (elt m1 1) 2) (/ (elt m1 2) 2))) ) :rpy (float-vector (random 6.28) (random 6.28) (random 6.28) )) )
  (setq target (make-coords :pos (v+ (float-vector (random (elt mn 0)) (random (elt mn 1))  (random (elt mn 2)))  (v+ (send box2 :minpoint)  (float-vector (/ (elt m1 0) 2) (/ (elt m1 1) 2) (/ (elt m1 2) 2))) ) ) )

  (send bc :move-to target :world)
  )



;; main !!!!

;; (load "pot.l")
(setq *pot* (cooking-pot))

;; (load "potato-hoge.l")
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


;; switch objects list order
;; (objects (list *pot* *potato* *nakami*))
(objects (list *pot* *nakami* *potato*))
