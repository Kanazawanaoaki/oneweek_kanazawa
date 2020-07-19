;; 73b2の包丁で実測した値

(defclass knife-object
  :super cascaded-link
  :slots (sensors
	 handle0
	 attention0 
         ))
(defmethod knife-object
  (:init
   (&rest args &key (name "knife") (pos (float-vector 0 0 0)) (rot (unit-matrix 3)) &allow-other-keys)
   (let (c bc b1 b2
         blink0
                 )
     (send-super* :init :name name args)

     ;; definition of link
     (setq b1 (make-cube 130 15 30))
     (send b1 :set-color :blue)
     (setq b2 (make-cube 160 5 50))
     (send b2 :locate #f(145 0 -10))
     (send b2 :set-color :yellow)

     (send b1 :assoc b2)

     ;; definition of :knife-bodyset2
     (setq blink0 (instance bodyset-link :init (make-cascoords) :bodies (list b1 b2) :name :knife-bodyset2 :weight 1 :centroid (float-vector 0.0 0.0 0.0) :inertia-tensor #2f((1.0 0.0 0.0) (0.0 1.0 0.0) (0.0 0.0 1.0))))

     ;; definition of assoc
     (send self :assoc blink0)

     ;; definition of end-coords

     ;; definition of joint


     ;; definition of :handle
     (setq handle0 (make-cascoords :pos (float-vector 0.0 0.0 0.0) :rot #2f((1.0 0.0 0.0) (0.0 1.0 0.0) (0.0 0.0 1.0)) :name "handle0"))
     (send blink0 :assoc handle0)

     ;; definition of :attention
     (setq attention0 (make-cascoords :pos (float-vector 140 0 -20) :rot #2f((1.0 0.0 0.0) (0.0 1.0 0.0) (0.0 0.0 1.0)) :name "attention0"))
     (send attention0 :rotate (deg2rad -7) :y)
     (send blink0 :assoc attention0)

     ;; init-ending 
     (setq links (list blink0))
     (setq joint-list (list))
     (send self :init-ending)
     (send self :move-to (make-coords :pos pos :rot rot))
     (send-all links :worldcoords)

     self))

  (:handle (&rest args) (forward-message-to-all (list  handle0) args))
  (:handle-handle0 (&rest args) (forward-message-to handle0 args))
  (:attention (&rest args) (forward-message-to-all (list attention0) args))
  (:attention-attention0 (&rest args) (forward-message-to-all attention0 args))
  (:button (&rest args) (forward-message-to-all (list ) args))
  )

(defun knife (&rest args) (instance* knife-object :init args))
