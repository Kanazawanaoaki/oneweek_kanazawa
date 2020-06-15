(defun point-mul (point x y z)
  (float-vector (* (elt point 0) x) (* (elt point 1) y) (* (elt point 2) z)))

(defun make-ellipsoid (width length height)
  (let (b1 b2)
    (setq x-scale (/ (float width) (float height)))
    (setq y-scale (/ (float length) (float height)))
    (setq b1 (make-sphere (/ height 2)))
    (setq v-list (list (point-mul (car (send b1 :vertices)) x-scale y-scale 1)))
    (dolist (x (cdr (send b1 :vertices))) (setq v-list (append v-list (list (point-mul x x-scale y-scale 1)))))
    (setq b2 (convex-hull-3d v-list)))
    )

(defclass onion-object
  :super cascaded-link
  :slots (
         ))

(defmethod onion-object
  (:init
   (&rest args &key (name "onion") (pos (float-vector 0 0 0)) (rot (unit-matrix 3)) &allow-other-keys)
   (let (link1 b1 b2 b3 b4 b5 b6 b7)
     (send-super* :init :name name args)
     
     (setq b1 (make-ellipsoid 90 90 60))
     (setq b6 (make-cone #f(0 0 20) v-list))
     (send b6 :locate (float-vector 0 0 (* (/ 60 5) 2)))
     
     (send b6 :set-color :peru)
     (send b1 :set-color :peru)

     (send b1 :assoc b6)

     ;; (send-super* :init (make-cascoords) :bodies (list b2 b1 b6 b7) args)))
     (setq link1 (instance bodyset-link :init (make-cascoords) :bodies (list b1 b6) :weight 1 :centroid (float-vector 0.0 0.0 0.0) :inertia-tensor #2f((1.0 0.0 0.0) (0.0 1.0 0.0) (0.0 0.0 1.0))))


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

  )

(defun onion (&rest args) (instance* onion-object :init args))
