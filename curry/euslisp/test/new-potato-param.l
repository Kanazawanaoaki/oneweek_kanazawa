(defun point-mul (point x y z)
  (float-vector (* (elt point 0) x) (* (elt point 1) y) (* (elt point 2) z)))

(defun make-potato-param-link (width length height)
  (setq x-scale (/ (float width) (float height)))
  (setq y-scale (/ (float length) (float height)))
  (setq b1 (make-sphere (/ height 2)))
  (setq v-list (list (point-mul (car (send b1 :vertices)) x-scale y-scale 1)))
  (dolist (x (cdr (send b1 :vertices))) (setq v-list (append v-list (list (point-mul x x-scale y-scale 1)))))
  (setq b2 (convex-hull-3d v-list))

  (send b2 :set-color :saddlebrown)

  (setq *potato* (instance bodyset-link :init (make-cascoords) :bodies (list b2) :weight 1 :centroid (float-vector 0.0 0.0 0.0) :inertia-tensor #2f((1.0 0.0 0.0) (0.0 1.0 0.0) (0.0 0.0 1.0))))
  )


(make-potato-param-link 90 70 60)

(send *potato* :translate #f(0 0 50))

;; set arrow
(load "models/arrow-object.l")
(setq *arrow* (arrow))

(objects (list *potato*))

(send *viewer* :draw-objects)

