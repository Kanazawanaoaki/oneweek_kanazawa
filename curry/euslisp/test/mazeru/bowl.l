(defclass bowl-object
  :super cascaded-link
  :slots (content
         ))

(defmethod bowl-object
  (:init
   (&rest args &key (name "bowl") (pos (float-vector 0 0 0)) (rot (unit-matrix 3)) &allow-other-keys)
   (let (link1 b1 b2 b3 b4 b5)
     (send-super* :init :name name args)

     ;; definition of link
     (setq b1 (make-sphere 70))
     (setq b2 (make-cube 1000 1000 100))
     (send b2 :locate #f(0 0 51))
     (setq b3 (make-sphere 65))
     (setq b4 (make-cylinder 35 5))
     (send b4 :locate #f(0 0 -59))
     (setq b5 (make-cube 1000 1000 40))
     (send b5 :locate #f(0 0 -78))

     (setq b1 (body- b1 b2))
     (setq b1 (body- b1 b3))
     (setq b1 (body- b1 b5))

     ;; add
     (setq content (body- b3 b5))
     (setq content (body- content b2))
     (send b1 :assoc content)
     
     (send b1 :assoc b4)
     (send b1 :locate #f(0 0 60))

     (send b1 :set-color :Silver)
     (send b4 :set-color :Silver) 

     (setq link1 (instance bodyset-link :init (make-cascoords) :bodies (list b1 b4) :weight 1 :centroid (float-vector 0.0 0.0 0.0) :inertia-tensor #2f((1.0 0.0 0.0) (0.0 1.0 0.0) (0.0 0.0 1.0))))


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

  )

(defun bowl (&rest args) (instance* bowl-object :init args))
