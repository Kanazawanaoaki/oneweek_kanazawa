(defclass roux-object
  :super bodyset-link
  :slots (
         ))

(defmethod roux-object
  (:init
   (&rest args &key (name "roux") (pos (float-vector 0 0 0)) (rot (unit-matrix 3)) &allow-other-keys)
   (let (rb2)
     (setq rb1 (make-cube 60 130 15))
     (setq rb2 (make-cube 56 126 13))
     (send rb2 :locate #f(0 0 1))
     (setq rb1 (body- nb1 nb2))
     (send rb1 :set-color :SandyBrown)
     
     (setq r1 (make-cube 26 40 10))
     (send r1 :locate #f(14 42 0))
     (send r1 :set-color :Sienna)
     
     (setq r2 (make-cube 26 40 10))
     (send r2 :locate #f(-14 42 0))
     (send r2 :set-color :Sienna)
     
     (setq r3 (make-cube 26 40 10))
     (send r3 :locate #f(14 0 0))
     (send r3 :set-color :Sienna)
     
     (setq r4 (make-cube 26 40 10))
     (send r4 :locate #f(-14 0 0))
     (send r4 :set-color :Sienna)
     
     (setq r5 (make-cube 26 40 10))
     (send r5 :locate #f(14 -42 0))
     (send r5 :set-color :Sienna)
     
     (setq r6 (make-cube 26 40 10))
     (send r6 :locate #f(-14 -42 0))
     (send r6 :set-color :Sienna)

     (send rb1 :assoc r1)
     (send rb1 :assoc r2)
     (send rb1 :assoc r3)
     (send rb1 :assoc r4)
     (send rb1 :assoc r5)
     (send rb1 :assoc r6)

     (send-super* :init (make-cascoords) :bodies (list rb1 r1 r2 r3 r4 r5 r6) args)))
  )

(defun roux (&rest args) (instance* roux-object :init args))

