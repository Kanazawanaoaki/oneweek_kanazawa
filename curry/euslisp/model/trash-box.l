(defclass trash-box-object
  :super cascaded-link
  :slots (
         ))

(defmethod trash-box-object
  (:init
   (&rest args &key (name "trash-box") (pos (float-vector 0 0 0)) (rot (unit-matrix 3)) &allow-other-keys)
   (let (link1 b1 b2)
     (send-super* :init :name name args)

     ;; definition of link
     (setq b1 (make-cylinder 60 80))
     (setq b2 (make-cylinder 56 76))
     (send b2 :locate #f(0 0 4))
     (setq b1 (body- b1 b2))
     (send b1 :set-color :white)

     (setq link1 (instance bodyset-link :init (make-cascoords) :bodies (list b1) :weight 1 :centroid (float-vector 0.0 0.0 0.0) :inertia-tensor #2f((1.0 0.0 0.0) (0.0 1.0 0.0) (0.0 0.0 1.0))))


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

(defun trash-box (&rest args) (instance* trash-box-object :init args))
