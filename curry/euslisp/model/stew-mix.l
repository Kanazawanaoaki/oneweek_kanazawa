(defun point-mul (point x y z)
  (float-vector (* (elt point 0) x) (* (elt point 1) y) (* (elt point 2) z)))

(defclass stew-mix-object
  :super bodyset-link
  :slots (
         ))

(defmethod stew-mix-object
  (:init
   (&rest args &key (name "stew-mix") (pos (float-vector 0 0 0)) (rot (unit-matrix 3)) &allow-other-keys)
   (let (rb1 rb2)
     (setq rb1 (make-cube 60 130 16))
     (send rb1 :set-color :Cornsilk)

     (setq x-scale 1)
     (setq y-scale 1.5)
     (setq rb2 (make-cylinder 25 14))
     (setq v-list (list (point-mul (car (send rb2 :vertices)) x-scale y-scale 1)))
     (dolist (x (cdr (send rb2 :vertices))) (setq v-list (append v-list (list (point-mul x x-scale y-scale 1)))))
     (setq rb2 (convex-hull-3d v-list))
     (send rb2 :locate #f(0 0 -5.9))
     (send rb2 :set-color :red)

     (send rb1 :assoc rb2)
     
     (send-super* :init (make-cascoords) :bodies (list rb1 rb2) args)))
  )

(defun stew-mix (&rest args) (instance* stew-mix-object :init args))
