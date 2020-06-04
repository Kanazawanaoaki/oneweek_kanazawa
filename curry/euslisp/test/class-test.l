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
   (let (b1 b2 b3 b4 r)
     (setq b1 (make-ellipsoid width length height))
     (setq b2 (make-cube (* 2 width) (* 2 length) (* 2 height)))
     (send b2 :locate (float-vector 0 (* (/ -2 3.0) length) 0))
   
     (setq b3 (make-cube (* 2 width) (* 2 length) (* 2 height)))
     (send b3 :locate (float-vector 0 (* (/ 2 3.0) length) 0))
   
     (setq b4 (make-cube (* 2 width) (* 2 length) (* 2 height)))
     (send b4 :locate (float-vector 0 0 (+ (* -1 height) 1)))
   
     (setq p2 (body- b1 b2))
     (setq b1 (body- b1 p2))
     (setq p4 (body- b1 b3))
     (setq b1 (body- b1 p4))
     (setq p1 (body- b1 b4))
     (setq p3 (body- b1 p1))
   
     (send p1 :assoc p2)
     (send p1 :assoc p3)
     (send p1 :assoc p4)

     (send p1 :set-color :saddlebrown)
     (send p2 :set-color :saddlebrown)
     (send p3 :set-color :saddlebrown)
     (send p4 :set-color :saddlebrown)
     (send p1 :newcoords (send self :copy-worldcoords))
     
     (push p1 r)
     (push p2 r)
     (push p3 r)
     (push p4 r)
     (setq geo::bodies r))
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
(objects (list *potato*))

(unix:sleep 1)

(send *potato* :translate #f(0 0 50))
(send *potato* :rotate (deg2rad 90) :z)
(send *viewer* :draw-objects)

(send *potato* :peel)
;; (send *viewer* :draw-objects)
(objects (list *potato*))
(unix:sleep 1)

(send p1 :set-color :moccasin)
(send *viewer* :draw-objects)
;; (objects (list *potato*))
(unix:sleep 1)

;; (send *potato* :cut)
;; ;; (send *viewer* :draw-objects)
;; (objects (list *potato*))
;; (unix:sleep 1)

;; (defun make-potato-param-link (width length height)
;;   (setq x-scale (/ (float width) (float height)))
;;   (setq y-scale (/ (float length) (float height)))
;;   (setq b1 (make-sphere (/ height 2)))
;;   (setq v-list (list (point-mul (car (send b1 :vertices)) x-scale y-scale 1)))
;;   (dolist (x (cdr (send b1 :vertices))) (setq v-list (append v-list (list (point-mul x x-scale y-scale 1)))))
;;   (setq b1 (convex-hull-3d v-list))

;;   (setq b2 (make-cube (* 2 width) (* 2 length) (* 2 height)))
;;   (send b2 :locate (float-vector 0 (* (/ -2 3.0) length) 0))

;;   (setq b3 (make-cube (* 2 width) (* 2 length) (* 2 height)))
;;   (send b3 :locate (float-vector 0 (* (/ 2 3.0) length) 0))

;;   (setq b4 (make-cube (* 2 width) (* 2 length) (* 2 height)))
;;   (send b4 :locate (float-vector 0 0 (+ (* -1 height) 1)))

;;   (setq p2 (body- b1 b2))
;;   (setq b1 (body- b1 p2))
;;   (setq p4 (body- b1 b3))
;;   (setq b1 (body- b1 p4))
;;   (setq p1 (body- b1 b4))
;;   (setq p3 (body- b1 p1))

;;   (send p1 :assoc p2)
;;   (send p1 :assoc p3)
;;   (send p1 :assoc p4)

;;   (send p1 :set-color :saddlebrown)
;;   (send p2 :set-color :saddlebrown)
;;   (send p3 :set-color :saddlebrown)
;;   (send p4 :set-color :saddlebrown)

;;   (setq *potato* (instance bodyset-link :init (make-cascoords) :bodies (list p1 p2 p3 p4) :weight 1 :centroid (float-vector 0.0 0.0 0.0) :inertia-tensor #2f((1.0 0.0 0.0) (0.0 1.0 0.0) (0.0 0.0 1.0))))
;;   )


;; (defun test (w l h)
  
;;   ;; (make-potato-param-link 90 70 60)
;;   (make-potato-param-link w l h)
  
;;   (send *potato* :translate #f(0 0 50))

;;   ;; set arrow
;;   (load "models/arrow-object.l")
;;   (setq *arrow* (arrow))

;;   (send p2 :translate #f(0 20 0))
;;   (send p4 :translate #f(0 -20 0))
;;   (send p1 :translate #f(0 0 30))
;;   (send p3 :translate #f(0 0 -30))


;;   (objects (list *potato*))


;;   (send *viewer* :draw-objects)
;;   )

;; (test 90 70 60)
