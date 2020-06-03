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

(defun box-approximation (body)
  (setq first-point (car (send body :vertices)))
  (setq x-max (elt first-point 0))
  (setq x-min (elt first-point 0))
  (setq y-max (elt first-point 1))
  (setq y-min (elt first-point 1))
  (setq z-max (elt first-point 2))
  (setq z-min (elt first-point 2))
  (dolist (x (cdr (send body :vertices)))
    (if (> (elt x 0) x-max) (setq x-max (elt x 0)))
    (if (> (elt x 1) y-max) (setq y-max (elt x 1)))
    (if (> (elt x 2) z-max) (setq z-max (elt x 2)))
    (if (< (elt x 0) x-min) (setq x-min (elt x 0)))
    (if (< (elt x 1) y-min) (setq y-min (elt x 1)))
    (if (< (elt x 2) z-min) (setq z-min (elt x 2))))
  (list x-max x-min y-max y-min z-max z-min)
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
     (send b :set-color :gray90)
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

(setq *potato* (instance potato :init :w 90 :l 60 :h 30))
(objects (list *potato*))


(unix:sleep 1)

;; (send *potato* :translate #f(0 0 50))
;; (send *potato* :rotate (deg2rad 90) :z)
;; (send *viewer* :draw-objects)

(send *potato* :change-color)
;; (send *viewer* :draw-objects)
(objects (list *potato*))
(unix:sleep 1)

(send *potato* :cut)
;; (send *viewer* :draw-objects)
(objects (list *potato*))
(unix:sleep 1)

(send *potato* :cut)
;; (send *viewer* :draw-objects)
(objects (list *potato*))
(unix:sleep 1)


;; ;; this requries https://github.com/euslisp/jskeus/pull/560
;; ;; (load "/home/k-okada/catkin_ws/ws_euslisp/src/jskeus/irteus/irtviewer.l")
;; (load "../../tmpfiles/irtviewer.l")

;; (with-save-animgif
;;  "potato.gif" 

;;  (setq *potato* (instance potato :init :w 90 :l 60 :h 30))
;;  (objects (list *potato*))

;;  (dotimes (i 10)
;;    (x::window-main-one)
;;    (send *irtviewer* :draw-objects)
;;    (unix:usleep 100000))

;;  ;; (send *potato* :translate #f(0 0 50))
;;  ;; (send *potato* :rotate (deg2rad 90) :z)
;;  ;; (send *viewer* :draw-objects)

;;  (send *potato* :change-color)
;;  ;; (send *viewer* :draw-objects)
;;  (objects (list *potato*))

;;  (dotimes (i 10)
;;    (x::window-main-one)
;;    (send *irtviewer* :draw-objects)
;;    (unix:usleep 100000))

;;  (send *potato* :cut)
;;  ;; (send *viewer* :draw-objects)
;;  (objects (list *potato*))

;;  (dotimes (i 10)
;;    (x::window-main-one)
;;    (send *irtviewer* :draw-objects)
;;    (unix:usleep 100000))

;;  (send *potato* :cut)
;;  ;; (send *viewer* :draw-objects)
;;  (objects (list *potato*))

;;  (dotimes (i 10)
;;    (x::window-main-one)
;;    (send *irtviewer* :draw-objects)
;;    (unix:usleep 100000))

;;  )
