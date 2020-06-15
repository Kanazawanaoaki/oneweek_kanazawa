(defclass carrot-object
  :super cascaded-link
  :slots (
         ))

(defmethod carrot-object
(:init
   (&rest args &key (name "carrot") (pos (float-vector 0 0 0)) (rot (unit-matrix 3)) &allow-other-keys)
   (let (link1 b1 b2 b3)
     (send-super* :init :name name args)
     (setq v-list (list #f(100.0 -15.0 25.9808) #f(100.0 -25.9808 15.0) #f(100.0 -30.0 -4.085621e-14) #f(100.0 -25.9808 -15.0) #f(100.0 -15.0 -25.9808) #f(100.0 2.842171e-14 -30.0) #f(100.0 15.0 -25.9808) #f(100.0 25.9808 -15.0) #f(100.0 30.0 1.598721e-14) #f(100.0 25.9808 15.0) #f(100.0 15.0 25.9808) #f(100.0 0.0 30.0)))
     
     (setq b2 (make-cone #f(-100 0 0) v-list))

     (setq b3 (make-sphere 30))
     (send b3 :locate #f(100 0 0))
     (setq b4 (make-cube 100 100 100))
     (send b4 :translate #f(49 0 0))
     (setq b3 (body- b3 b4))

     (send b2 :set-color :orangered)
     (send b3 :set-color :orangered)

     (send b2 :assoc b3)

     (setq link1 (instance bodyset-link :init (make-cascoords) :bodies (list b2 b3) :weight 1 :centroid (float-vector 0.0 0.0 0.0) :inertia-tensor #2f((1.0 0.0 0.0) (0.0 1.0 0.0) (0.0 0.0 1.0))))

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

(defun carrot (&rest args) (instance* carrot-object :init args))
