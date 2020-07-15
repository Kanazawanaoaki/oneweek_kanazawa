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

(defun body-cut-x (abody box)
  (let (b1 b2 c-flag i)
    (setq c-flag nil)
    (setq i 0)
    (until c-flag
	   (catch 'hoge
	     (unwind-protect
		 (progn
		   (setq *error-handler* #'(lambda (code msg1 form &optional msg2) (throw 'hoge -1)));;エラーハンドラを変える
		   (setq b1 (body- abody box)) ;;ここでエラーが起こるとcatchを抜ける
		   (setq c-flag t)
		   0)
	       (setq *error-handler* #'euserror)));;エラーハンドラをもとに戻す
	   (send box :locate #f(-1 0 0))
	   (setq i (+ i 1))
	   )
    
    (setq b2 (body- abody b1))
    (list b1 b2))) 

(defclass potato-object
  :super bodyset-link
  :slots (width
	  length
	  height
	  ))

(defmethod potato-object
  (:init
   (&rest args &key (w 90) (l 60) (h 60) &allow-other-keys)
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
     
     (setq b5 (make-cube (* 2 width) (* 2 length) (* 2 height)))
     (send b5 :locate (float-vector (+ (/ width 2) 15) 0 0))
     (setq p5 (body- b1 b5))
     (setq b1 (body- b1 p5))
     
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
     (send p1 :assoc p5)

     (send p1 :set-color :saddlebrown)
     (send p2 :set-color :saddlebrown)
     (send p3 :set-color :saddlebrown)
     (send p4 :set-color :saddlebrown)
     (send p5 :set-color :saddlebrown)
     (send p1 :newcoords (send self :copy-worldcoords))
     (send self :assoc p1)
     
     (push p1 r)
     (push p2 r)
     (push p3 r)
     (push p4 r)
     (push p5 r)
     (setq geo::bodies r))
     )
  (:cut
   ()
   (let (b1 b2 b3 b4 b5 b6 b7 r)
     (setq b1 (make-ellipsoid width length height))

     (setq b7 (make-cube (* 2 width) (* 2 length) (* 2 height)))
     (send b7 :locate (float-vector (- (/ width -2) 15) 0 0))
     (setq p7 (body- b1 b7))
     (setq b1 (body- b1 p7))
     
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

     (send p1 :set-color :saddlebrown)
     (send p2 :set-color :saddlebrown)
     (send p3 :set-color :saddlebrown)
     (send p4 :set-color :saddlebrown)
     (send p5 :set-color :saddlebrown)
     (send p6 :set-color :saddlebrown)
     (send p7 :set-color :saddlebrown)

     (send p4 :assoc p1)
     (send p4 :assoc p2)
     (send p4 :assoc p3)
     (send p4 :assoc p5)
     (send p4 :assoc p6)
     (send p4 :assoc p7)

     (setq *cut-point-1* (make-cascoords :pos (float-vector (- (/ width 2) 15) 0 (/ height -2))))
     (send *cut-point-1* :rotate (deg2rad 90) :z)
     (send p1 :assoc *cut-point-1*)
     
     (setq *cut-point-2* (make-cascoords :pos (float-vector 0 0 (/ height -2))))
     (send *cut-point-2* :rotate (deg2rad 90) :z)
     (send p1 :assoc *cut-point-2*)

     (setq *cut-point-3* (make-cascoords :pos (float-vector 0 0 (/ height -6))))
     (send *cut-point-3* :rotate (deg2rad 90) :y)
     (send *cut-point-3* :rotate (deg2rad 90) :z)
     (send p2 :assoc *cut-point-3*)
     
     (setq *cut-point-4* (make-cascoords :pos (float-vector 0 0 (/ height 6))))
     (send *cut-point-4* :rotate (deg2rad 90) :y)
     (send *cut-point-4* :rotate (deg2rad 90) :z)
     (send p1 :assoc *cut-point-4*)

     (setq *cut-point-5* (make-cascoords :pos (float-vector 0 0 (/ height -6))))
     (send *cut-point-5* :rotate (deg2rad -90) :z)
     (send *cut-point-5* :rotate (deg2rad 90) :x)
     (send p5 :assoc *cut-point-5*)

     (setq *cut-point-6* (make-cascoords :pos (float-vector 0 0 (/ height 6))))
     (send *cut-point-6* :rotate (deg2rad -90) :z)
     (send *cut-point-6* :rotate (deg2rad 90) :x)
     (send p4 :assoc *cut-point-6*)

     (send p4 :newcoords (send self :copy-worldcoords))
     (send self :assoc p4)
     
     (push p1 r)
     (push p2 r)
     (push p3 r)
     (push p4 r)
     (push p5 r)
     (push p6 r)
     (push p7 r)
     (setq geo::bodies r))
   )
  )

(defun potato (&rest args) (instance* potato-object :init args))
