(defun point-mul (point x y z)
  (float-vector (* (elt point 0) x) (* (elt point 1) y) (* (elt point 2) z)))

(defun make-ellipsoid (width length height)
  (setq x-scale (/ (float width) (float height)))
  (setq y-scale (/ (float length) (float height)))
  (setq b1 (make-sphere (/ height 2)))
  (setq v-list (list (point-mul (car (send b1 :vertices)) x-scale y-scale 1)))
  (dolist (x (cdr (send b1 :vertices))) (setq v-list (append v-list (list (point-mul x x-scale y-scale 1)))))
  (setq b2 (convex-hull-3d v-list))
  )

(defclass tomato
  :super bodyset-link
  :slots (width
	  length
	  height
	  ))

(defmethod tomato
  (:init
   (&rest args &key (w 90) (l 60) (h 60))
   (let (b)
     (setq width w)
     (setq length l)
     (setq height h)
     (setq b (make-ellipsoid w l h))
     (send b :set-color :red)
     (send-super* :init (make-cascoords) :bodies (list b) args)))
  (:print-info
   ()
   (format t "width ~A, length ~A, height ~A~%" width length height))
  (:cut
   ()
   (let (b1 b2 b3 b4 b5 b6 r)
     (setq b1 (make-ellipsoid width length height))
     (setq b2 (make-cube (* 2 width) (* 2 length) (* 2 height)))
     (send b2 :locate (float-vector (+ (* -1 width) 1) 0 0))

     (setq b3 (body- b1 b2))
     (setq b4 (body- b1 b3))

     (setq b5 (make-cube (* 2 width) (* 2 length) (* 2 height)))
     (send b5 :locate (float-vector 0 0 (/ (* -5 height) 6)))
     (setq b6 (make-cube (* 2 width) (* 2 length) (* 2 height)))
     (send b6 :locate (float-vector 0 0 (/ (* -7 height) 6)))
     
     (setq p1 (body- b3 b5))
     (setq p4 (body- b4 b5))
     (setq b3 (body- b3 p1))
     (setq b4 (body- b4 p4))

     (setq p2 (body- b3 b6))
     (setq p5 (body- b4 b6))
     (setq p3 (body- b3 p2))
     (setq p6 (body- b4 p5))

     (send p1 :set-color :moccasin)
     (send p2 :set-color :moccasin)
     (send p3 :set-color :moccasin)
     (send p4 :set-color :moccasin)
     (send p5 :set-color :moccasin)
     (send p6 :set-color :moccasin)

     (send p4 :assoc p1)
     (send p4 :assoc p2)
     (send p4 :assoc p3)
     (send p4 :assoc p5)
     (send p4 :assoc p6)
     
     (setq *cut-point-1* (make-cascoords :pos (float-vector 0 0 (/ height -2))))
     (send *cut-point-1* :rotate (deg2rad 90) :z)
     (send p1 :assoc *cut-point-1*)

     (setq *cut-point-2* (make-cascoords :pos (float-vector 0 0 (/ height -6))))
     (send *cut-point-2* :rotate (deg2rad 90) :y)
     (send *cut-point-2* :rotate (deg2rad 90) :z)
     (send p2 :assoc *cut-point-2*)
     
     (setq *cut-point-3* (make-cascoords :pos (float-vector 0 0 (/ height 6))))
     (send *cut-point-3* :rotate (deg2rad 90) :y)
     (send *cut-point-3* :rotate (deg2rad 90) :z)
     (send p1 :assoc *cut-point-3*)

     (setq *cut-point-4* (make-cascoords :pos (float-vector 0 0 (/ height -6))))
     (send *cut-point-4* :rotate (deg2rad -90) :z)
     (send *cut-point-4* :rotate (deg2rad 90) :x)
     (send p5 :assoc *cut-point-4*)

     (setq *cut-point-5* (make-cascoords :pos (float-vector 0 0 (/ height 6))))
     (send *cut-point-5* :rotate (deg2rad -90) :z)
     (send *cut-point-5* :rotate (deg2rad 90) :x)
     (send p4 :assoc *cut-point-5*)

     (send p4 :newcoords (send self :copy-worldcoords))
     (send self :assoc p4)
     
     (push p1 r)
     (push p2 r)
     (push p3 r)
     (push p4 r)
     (push p5 r)
     (push p6 r)
     (setq geo::bodies r))
   )
  )


(setq *tomato* (instance tomato :init :w 70 :l 70 :h 60))
(send *tomato* :translate #f(0 0 50))

;; set arrow
(load "models/arrow-object.l")
(setq *arrow* (arrow))

(objects (list *tomato*))

(send *viewer* :draw-objects)
