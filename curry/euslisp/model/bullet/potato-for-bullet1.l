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
  :super cascaded-link
  :slots (
         ))

(defmethod potato-object
  (:init
   (&rest args &key (name "potato") (pos (float-vector 0 0 0)) (rot (unit-matrix 3)) &allow-other-keys)
   (let (link1 b)
     (send-super* :init :name name args)

     ;; definition of link
     (setq b (make-ellipsoid 90 60 60))
     (send b :set-color :saddlebrown)
     
     (setq link1 (instance bodyset-link :init (make-cascoords) :bodies (list b) :weight 1 :centroid (float-vector 0.0 0.0 0.0) :inertia-tensor #2f((1.0 0.0 0.0) (0.0 1.0 0.0) (0.0 0.0 1.0))))


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

(defun potato (&rest args) (instance* potato-object :init args))
