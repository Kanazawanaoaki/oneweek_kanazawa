(defclass peeler-object
  :super cascaded-link
  :slots (
         ))

(defmethod peeler-object
  (:init
   (&rest args &key (name "peeler") (pos (float-vector 0 0 0)) (rot (unit-matrix 3)) &allow-other-keys)
   (let (link1 b1 b2 b3 b4 b5)
     (send-super* :init :name name args)

     ;; definition of link
     (setq b1 (make-cube 12 100 12))

     (setq b2 (make-cylinder 30 5))
     (setq b3 (make-cylinder 25 5))
     (setq b2 (body- b2 b3))
     (setq b4 (make-cube 100 100 20))
     (send b4 :locate #f(0 51 0))
     (setq b2 (body- b2 b4))

     (setq b5 (make-cube 50 5 2))
     (send b5 :locate #f(0 0 2))
     (send b5 :set-color :white)

     (send b2 :assoc b5)
     (send b2 :locate #f(0 80 0))

     (send b1 :assoc b2)
     (send b2 :set-color :red)
     (send b1 :set-color :red)
     
     (setq link1 (instance bodyset-link :init (make-cascoords) :bodies (list b1 b2 b5) :weight 1 :centroid (float-vector 0.0 0.0 0.0) :inertia-tensor #2f((1.0 0.0 0.0) (0.0 1.0 0.0) (0.0 0.0 1.0))))


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

(defun peeler (&rest args) (instance* peeler-object :init args))
