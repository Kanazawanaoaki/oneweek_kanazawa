;;
;; DO NOT EDIT THIS FILE
;; this file is automatically generated from euslisp+euslib version 
;;
;;
(defclass knife-object
  :super cascaded-link
  :slots (sensors
	 handle0
	 attention0 
         ))
(defmethod knife-object
  (:init
   (&rest args &key (name "knife") (pos (float-vector 0 0 0)) (rot (unit-matrix 3)) &allow-other-keys)
   (let (c bc
         blink0
                 )
     (send-super* :init :name name args)

     ;; definition of link

     ;; definition of :knife-bodyset2
     (setq bc (list
       (instance faceset :init :faces (list
         (instance face :init :vertices (list (float-vector 60.0 5.0 12.5) (float-vector -60.0 5.0 12.5) (float-vector -60.0 -5.0 12.5) (float-vector 60.0 -5.0 12.5)))
         (instance face :init :vertices (list (float-vector -60.0 5.0 -12.5) (float-vector 60.0 5.0 -12.5) (float-vector 60.0 -5.0 -12.5) (float-vector -60.0 -5.0 -12.5)))
         (instance face :init :vertices (list (float-vector 60.0 5.0 12.5) (float-vector 60.0 5.0 -12.5) (float-vector -60.0 5.0 -12.5) (float-vector -60.0 5.0 12.5)))
         (instance face :init :vertices (list (float-vector 60.0 -5.0 12.5) (float-vector 60.0 -5.0 -12.5) (float-vector 60.0 5.0 -12.5) (float-vector 60.0 5.0 12.5)))
         (instance face :init :vertices (list (float-vector -60.0 -5.0 12.5) (float-vector -60.0 -5.0 -12.5) (float-vector 60.0 -5.0 -12.5) (float-vector 60.0 -5.0 12.5)))
         (instance face :init :vertices (list (float-vector -60.0 5.0 12.5) (float-vector -60.0 5.0 -12.5) (float-vector -60.0 -5.0 -12.5) (float-vector -60.0 -5.0 12.5)))
       ))
       (instance faceset :init :faces (list
         (instance face :init :vertices (list (float-vector 60.0 1.0 12.5) (float-vector 60.0 1.0 -32.5) (float-vector 230.0 1.0 -12.5) (float-vector 180.0 1.0 12.5)))
         (instance face :init :vertices (list (float-vector 60.0 -1.0 -32.5) (float-vector 60.0 -1.0 12.5) (float-vector 180.0 -1.0 12.5) (float-vector 230.0 -1.0 -12.5)))
         (instance face :init :vertices (list (float-vector 60.0 1.0 12.5) (float-vector 60.0 -1.0 12.5) (float-vector 60.0 -1.0 -32.5) (float-vector 60.0 1.0 -32.5)))
         (instance face :init :vertices (list (float-vector 180.0 1.0 12.5) (float-vector 180.0 -1.0 12.5) (float-vector 60.0 -1.0 12.5) (float-vector 60.0 1.0 12.5)))
         (instance face :init :vertices (list (float-vector 230.0 1.0 -12.5) (float-vector 230.0 -1.0 -12.5) (float-vector 180.0 -1.0 12.5) (float-vector 180.0 1.0 12.5)))
         (instance face :init :vertices (list (float-vector 60.0 1.0 -32.5) (float-vector 60.0 -1.0 -32.5) (float-vector 230.0 -1.0 -12.5) (float-vector 230.0 1.0 -12.5)))
       ))
       ))
     (dolist (b (cdr bc)) (send (car bc) :assoc b))
     (send (elt bc 0) :set-color :blue)
     (send (elt bc 1) :set-color :yellow)
     (setq blink0 (instance bodyset-link :init (make-cascoords) :bodies bc :name :knife-bodyset2 :weight 1 :centroid (float-vector 0.0 0.0 0.0) :inertia-tensor #2f((1.0 0.0 0.0) (0.0 1.0 0.0) (0.0 0.0 1.0))))

     ;; definition of assoc
     (send self :assoc blink0)

     ;; definition of end-coords

     ;; definition of joint


     ;; definition of :handle
     (setq handle0 (make-cascoords :pos (float-vector 0.0 0.0 0.0) :rot #2f((1.0 0.0 0.0) (0.0 1.0 0.0) (0.0 0.0 1.0)) :name "handle0"))
     (send blink0 :assoc handle0)

     ;; definition of :attention
     (setq attention0 (make-cascoords :pos (float-vector 165 0 -19) :rot #2f((1.0 0.0 0.0) (0.0 1.0 0.0) (0.0 0.0 1.0)) :name "attention0"))
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
;; (format *error-output* "(instance knife-object :init) for generating model~%")