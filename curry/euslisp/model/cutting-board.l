(defclass cutting-board-object
  :super cascaded-link
  :slots (
         ))

(defmethod cutting-board-object
  (:init
   (&rest args &key (name "cutting-board") (pos (float-vector 0 0 0)) (rot (unit-matrix 3)) &allow-other-keys)
   (let (link1 bc)
     (send-super* :init :name name args)

     ;; definition of link
     (setq bc (make-cube 200 350 10))
     (send bc :locate #f(0 0 5))
     (send bc :set-color :white)

     (setq link1 (instance bodyset-link :init (make-cascoords) :bodies (list bc) :weight 1 :centroid (float-vector 0.0 0.0 0.0) :inertia-tensor #2f((1.0 0.0 0.0) (0.0 1.0 0.0) (0.0 0.0 1.0))))


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

(defun cutting-board (&rest args) (instance* cutting-board-object :init args))
