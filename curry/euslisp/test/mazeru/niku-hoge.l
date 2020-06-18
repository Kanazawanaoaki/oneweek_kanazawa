(defclass niku-object
  :super bodyset-link
  :slots (
         ))

(defmethod niku-object
  (:init
   (&rest args &key (name "niku") (pos (float-vector 0 0 0)) (rot (unit-matrix 3)) &allow-other-keys)
   (let (nb2)
     (setq nb1 (make-cube 120 200 40))
     (setq nb2 (make-cube 100 180 30))
     (send nb2 :locate #f(0 0 5))
     (setq nb1 (body- nb1 nb2))
     (send nb1 :set-color :SandyBrown)

     (setq n1 (make-cube 30 40 16))
     (send n1 :locate #f(0 0 -2))
     (send n1 :set-color :salmon)
     (send n1 :locate #f(30 68 0))

     (setq n2 (make-cube 31 35 16))
     (send n2 :locate #f(0 0 -2))
     (send n2 :set-color :salmon)
     (send n2 :locate #f(-10 65 0))

     (setq n3 (make-cube 25 40 16))
     (send n3 :locate #f(0 0 -2))
     (send n3 :set-color :salmon)
     (send n3 :locate #f(25 20 0))

     (setq n4 (make-cube 30 36 16))
     (send n4 :locate #f(0 0 -2))
     (send n4 :set-color :salmon)
     (send n4 :locate #f(-25 25 0))
     (send n4 :rotate (deg2rad 90) :z :world)

     (setq n5 (make-cube 30 40 16))
     (send n5 :locate #f(0 0 -2))
     (send n5 :set-color :salmon)
     (send n5 :locate #f(25 -20 0))
     (send n5 :rotate (deg2rad 90) :z :world)

     (setq n6 (make-cube 28 37 16))
     (send n6 :locate #f(0 0 -2))
     (send n6 :set-color :salmon)
     (send n6 :locate #f(-22 -17 0))
     (send n6 :rotate (deg2rad 60) :z :world)

     (setq n8 (make-cube 27 43 16))
     (send n8 :locate #f(0 0 -2))
     (send n8 :set-color :salmon)
     (send n8 :locate #f(-27 -64 0))

     (setq n7 (make-cube 30 30 16))
     (send n7 :locate #f(0 0 -2))
     (send n7 :set-color :salmon)
     (send n7 :locate #f(18 -61 0))


     (send nb1 :assoc n1)
     (send nb1 :assoc n2)
     (send nb1 :assoc n3)
     (send nb1 :assoc n4)
     (send nb1 :assoc n5)
     (send nb1 :assoc n6)
     (send nb1 :assoc n7)
     (send nb1 :assoc n8)

     (send-super* :init (make-cascoords) :bodies (list nb1 n1 n2 n3 n4 n5 n6 n7 n8) args)))
  )

(defun niku (&rest args) (instance* niku-object :init args))
