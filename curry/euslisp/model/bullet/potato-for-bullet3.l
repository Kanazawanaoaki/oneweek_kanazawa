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

(defclass potato-object-3
  :super cascaded-link
  :slots (
         ))

(defmethod potato-object-3
  (:init
   (&rest args &key (name "potato") (pos (float-vector 0 0 0)) (rot (unit-matrix 3)) &allow-other-keys)
   (let (b1 b2 b3 b4 b5 b6 r)
     (send-super* :init :name name args)

     ;; definition of link
     (setq width 90)
     (setq length 60)
     (setq height 60)

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
     
     (setq link1 (instance bodyset-link :init (make-cascoords) :bodies (list p3) :weight 1 :centroid (float-vector 0.0 0.0 0.0) :inertia-tensor #2f((1.0 0.0 0.0) (0.0 1.0 0.0) (0.0 0.0 1.0))))


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

(defun potato3 (&rest args) (instance* potato-object-3 :init args))
