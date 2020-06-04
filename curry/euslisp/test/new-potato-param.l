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

(defclass potato
  :super bodyset-link
  :slots (width
	  length
	  height
	  ))

(defmethod potato
  (:init
   (&rest args &key (w 90) (l 60) (h 60))
   (let (b)
     (setq width w)
     (setq length l)
     (setq height h)
     (setq b (make-ellipsoid w l h))
     (send b :set-color :saddlebrown)
     (send-super* :init (make-cascoords) :bodies (list b) args)))
  (:print-info
   ()
   (format t "width ~A, length ~A, height ~A~%" width length height))
  (:change-color
   ()
   (let (b r)
     (setq b (make-ellipsoid width length height))
     (send b :newcoords (send self :copy-worldcoords))
     (send b :set-color :saddlebrown)
     (push b r)
     (setq geo::bodies r)))
  (:peel
   ()
   )
  (:cut
   ()
   (let (r m c p)
     ;; for all bodies
     (dolist (abody geo::bodies)
       ;; (setq m (cdar (send abody :csg))) ;; get w/d/h
       (setq b-list (box-approximation abody))
       (print (list (- (elt b-list 0) (elt b-list 1)) (- (elt b-list 2) (elt b-list 3)) (-  (elt b-list 4) (elt b-list 5))))
       (setq m (float-vector (- (elt b-list 0) (elt b-list 1)) (- (elt b-list 2) (elt b-list 3)) (- (elt b-list 4) (elt b-list 5))))
       (setq c (send abody :get :face-color))
       (setq p (send abody :pos))
       ;; generate half size cube
       (setq b1 (make-cube (+ (/ (elt m 0) 2) 2) (+ (elt m 1) 2) (+ (elt m 2) 2)))
       (setq b2 (make-cube (+ (/ (elt m 0) 2) 2) (+ (elt m 1) 2) (+ (elt m 2) 2)))
       ;; move generated bodies
       (send b1 :locate (v+ p (float-vector (/ (elt m 0) -2) 0 0)))
       (send b2 :locate (v+ p (float-vector (/ (elt m 0) 2) 0 0)))
       (send b1 :set-color c)
       (send b2 :set-color c)
       
       (send abody :locate (float-vector (/ (elt m 0) -4) 0 0))
       (setq b1 (body- abody b1))
       (send abody :locate (float-vector (/ (elt m 0) 2) 0 0))
       (setq b2 (body- abody b2))
       (send b1 :locate (float-vector (/ (elt m 0) 4) 0 0))
       (send b2 :locate (float-vector (/ (elt m 0) -4) 0 0))
       
       (send self :assoc b1)
       (send self :assoc b2)
       (print (v+ p (float-vector (/ (elt m 0) 4) 0 0)))
       ;; use original color
       (send b1 :set-color c)
       (send b2 :set-color c)
       ;; push generated bodies to r
       (push b1 r)
       (push b2 r)
       )
       ;; replace geo::bodies with new bodies
     (setq geo::bodies r)))
  )

(setq *potato* (instance potato :init :w 90 :l 70 :h 60))

(send *potato* :translate #f(0 0 50))

;; set arrow
(load "models/arrow-object.l")
(setq *arrow* (arrow))

(objects (list *potato*))

(send *viewer* :draw-objects)

