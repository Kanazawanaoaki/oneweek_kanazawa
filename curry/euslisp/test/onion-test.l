(defun point-mul (point x y z)
  (float-vector (* (elt point 0) x) (* (elt point 1) y) (* (elt point 2) z)))

(defun make-ellipsoid (width length height)
  (let (b1 b2)
    (setq x-scale (/ (float width) (float height)))
    (setq y-scale (/ (float length) (float height)))
    (setq b1 (make-sphere (/ height 2)))
    (setq v-list (list (point-mul (car (send b1 :vertices)) x-scale y-scale 1)))
    (dolist (x (cdr (send b1 :vertices))) (setq v-list (append v-list (list (point-mul x x-scale y-scale 1)))))
    (setq b2 (convex-hull-3d v-list)))
    )

(defclass onion
  :super bodyset-link
  :slots (width
	  length
	  height
	  ))

(defmethod onion
  (:init
   (&rest args &key (w 90) (l 60) (h 60))
   (let (b1 b2)
     (setq width w)
     (setq length l)
     (setq height h)
     (setq b1 (make-ellipsoid w l h))
     (setq b2 (make-ellipsoid (- w 1) (- l 1) (- h 1)))
     (setq b1 (body- b1 b2))
     (setq v-list (list #f(6.9282 -4.0 0.0) #f(4.0 -6.9282 0.0) #f(-1.376677e-14 -8.0 0.0) #f(-4.0 -6.9282 0.0) #f(-6.9282 -4.0 0.0) #f(-8.0 8.437695e-15 0.0) #f(-6.9282 4.0 0.0) #f(-4.0 6.9282 0.0) #f(3.996803e-15 8.0 0.0) #f(4.0 6.9282 0.0) #f(6.9282 4.0 0.0) #f(8.0 0.0 0.0)))
     (setq b6 (make-cone #f(0 0 20) v-list))
     (send b6 :locate (float-vector 0 0 (* (/ height 5) 2)))
     
     (setq v-list (list #f(6.06218 -3.5 0.0) #f(3.5 -6.06218 0.0) #f(-1.110223e-14 -7.0 0.0) #f(-3.5 -6.06218 0.0) #f(-6.06218 -3.5 0.0) #f(-7.0 7.105427e-15 0.0) #f(-6.06218 3.5 0.0) #f(-3.5 6.062 0.0) #f(3.552714e-15 7.0 0.0) #f(3.5 6.06218 0.0) #f(6.06218 3.5 0.0) #f(7.0 0.0 0.0)))
     (setq b7 (make-cone #f(0 0 19) v-list))
     (send b7 :locate (float-vector 0 0 (* (/ height 5) 2)))
     
     (setq b6 (body- b6 b7))

     (send b6 :set-color :peru)
     (send b1 :set-color :peru)
     (send b7 :set-color :beige)
     (send b2 :set-color :beige)
     (send b2 :assoc b1)
     (send b2 :assoc b6)
     (send b2 :assoc b7)
     (send-super* :init (make-cascoords) :bodies (list b2 b1 b6 b7) args)))
  (:print-info
   ()
   (format t "width ~A, length ~A, height ~A~%" width length height))
  (:cut
   ()
   (let (b1 b2 b3 b4 b5 b6 b7 r)
     (setq b1 (make-ellipsoid width length height))
     (setq b2 (make-ellipsoid (- width 1) (- length 1) (- height 1)))
     (setq b1 (body- b1 b2))

     (setq v-list (list #f(6.9282 -4.0 0.0) #f(4.0 -6.9282 0.0) #f(-1.376677e-14 -8.0 0.0) #f(-4.0 -6.9282 0.0) #f(-6.9282 -4.0 0.0) #f(-8.0 8.437695e-15 0.0) #f(-6.9282 4.0 0.0) #f(-4.0 6.9282 0.0) #f(3.996803e-15 8.0 0.0) #f(4.0 6.9282 0.0) #f(6.9282 4.0 0.0) #f(8.0 0.0 0.0)))
     (setq b6 (make-cone #f(0 0 20) v-list))
     (send b6 :locate (float-vector 0 0 (* (/ height 5) 2)))
     
     (setq v-list (list #f(6.06218 -3.5 0.0) #f(3.5 -6.06218 0.0) #f(-1.110223e-14 -7.0 0.0) #f(-3.5 -6.06218 0.0) #f(-6.06218 -3.5 0.0) #f(-7.0 7.105427e-15 0.0) #f(-6.06218 3.5 0.0) #f(-3.5 6.062 0.0) #f(3.552714e-15 7.0 0.0) #f(3.5 6.06218 0.0) #f(6.06218 3.5 0.0) #f(7.0 0.0 0.0)))
     (setq b7 (make-cone #f(0 0 19) v-list))
     (send b7 :locate (float-vector 0 0 (* (/ height 5) 2)))

     (setq b6 (body- b6 b7))
     
     (setq b3 (make-cube (* 2 width) (* 2 length) (* 2 height)))
     (send b3 :locate (float-vector 0 (+ (* -1 length) 1) 0))

     (setq b4 (body- b1 b3))
     (setq b1 (body- b1 b4))
     (setq b5 (body- b2 b3))
     (setq b2 (body- b2 b5))
     (setq p1-4 (body- b6 b3))
     (setq p2-4 (body- b6 p1-4))
     (setq p1-3 (body- b7 b3))
     (setq p2-3 (body- b7 p1-3))
     
     (setq b3 (make-cube (* 2 width) (* 2 length) (* 2 height)))
     (send b3 :locate (float-vector 0 0 (* (/ height 3) -2)))

     (setq p2-1 (body- b2 b3))
     (setq b2 (body- b2 p2-1))
     (setq p2-2 (body- b1 b3))
     (setq b1 (body- b1 p2-2))
     (setq p1-1 (body- b5 b3))
     (setq b5 (body- b5 p1-1))
     (setq p1-2 (body- b4 b3))
     (setq b4 (body- b4 p1-2))
     
     (send b3 :locate (float-vector 0 0 (* (/ height 3) -2)))
     
     (setq p4-1 (body- b2 b3))
     (setq p6-1 (body- b2 p4-1))
     (setq p4-2 (body- b1 b3))
     (setq p6-2 (body- b1 p4-2))
     (setq p3-1 (body- b5 b3))
     (setq p5-1 (body- b5 p3-1))
     (setq p3-2 (body- b4 b3))
     (setq p5-2 (body- b4 p3-2))
     
     (send p1-1 :assoc p1-2)
     (send p1-1 :assoc p1-3)
     (send p1-1 :assoc p1-4)
     (send p2-1 :assoc p2-2)
     (send p2-1 :assoc p2-3)
     (send p2-1 :assoc p2-4)
     (send p3-1 :assoc p3-2)
     (send p4-1 :assoc p4-2)
     (send p5-1 :assoc p5-2)
     (send p6-1 :assoc p6-2)
     
     ;; set colors
     (send p1-2 :set-color :peru)
     (send p1-4 :set-color :peru)
     (send p2-2 :set-color :peru)
     (send p2-4 :set-color :peru)
     (send p3-2 :set-color :peru)
     (send p4-2 :set-color :peru)
     (send p5-2 :set-color :peru)
     (send p6-2 :set-color :peru)
     
     
     (send p1-1 :set-color :beige)
     (send p1-3 :set-color :beige)
     (send p2-1 :set-color :beige)
     (send p2-3 :set-color :beige)
     (send p3-1 :set-color :beige)
     (send p4-1 :set-color :beige)
     (send p5-1 :set-color :beige)
     (send p6-1 :set-color :beige)
     
     (setq *cut-point-1* (make-cascoords :pos (float-vector 0 0 (* -1 (/ height 2)))))
     (setq *cut-point-2* (make-cascoords :pos (float-vector 0 0 (* 1 (/ height 3)))))
     (send *cut-point-2* :rotate (deg2rad -90) :x)
     (send *cut-point-2* :rotate (deg2rad 180) :z :world)
     (setq *cut-point-3* (make-cascoords :pos (float-vector 0 0 (* -1 (/ height 3)))))
     (send *cut-point-3* :rotate (deg2rad -90) :x)
     (send *cut-point-3* :rotate (deg2rad 180) :z :world)
     (send *cut-point-3* :rotate (deg2rad 180) :z)
     
     (setq *cut-point-4* (make-cascoords :pos (float-vector 0 0 (* 1 (/ height 3)))))
     (send *cut-point-4* :rotate (deg2rad -90) :x)
     (setq *cut-point-5* (make-cascoords :pos (float-vector 0 0 (* -1 (/ height 3)))))
     (send *cut-point-5* :rotate (deg2rad -90) :x)
     (send *cut-point-5* :rotate (deg2rad 180) :z)
     
     (send p3-1 :assoc *cut-point-1*)
     (send p2-1 :assoc *cut-point-2*)
     (send p4-1 :assoc *cut-point-3*)
     (send p1-1 :assoc *cut-point-4*)
     (send p3-1 :assoc *cut-point-5*)

     (send p4-1 :assoc p2-1)
     (send p4-1 :assoc p6-1)
     (send p3-1 :assoc p1-1)
     (send p3-1 :assoc p5-1)
     (send p3-1 :assoc p4-1)

     (send p3-1 :newcoords (send self :copy-worldcoords))
     (send self :assoc p3-1)
    
     (push p3-1 r)
     (push p3-2 r)
     (push p1-1 r)
     (push p1-2 r)
     (push p1-3 r)
     (push p1-4 r)
     (push p2-1 r)
     (push p2-2 r)
     (push p2-3 r)
     (push p2-4 r)
     (push p4-1 r)
     (push p4-2 r)
     (push p5-1 r)
     (push p5-2 r)
     (push p6-1 r)
     (push p6-2 r)
     (setq geo::bodies r))
   )
  )


(setq *onion* (instance onion :init :w 90 :l 90 :h 70))
(send *onion* :translate #f(0 0 50))

(send *onion* :cut)

;; set arrow
(load "models/arrow-object.l")
(setq *arrow* (arrow))

(objects (list *onion*))

(send *viewer* :draw-objects)



(warn "please run (c1-1) or (exec-all)~%")

(defun c1-1 ()
  (send *arrow* :newcoords (send *cut-point-1* :copy-worldcoords))

  (send *viewer* :draw-objects)
  (warn "please run (c1-2)~%")
  )

(defun c1-2 ()
  (send p3-1 :dissoc p4-1)
  (send p4-1 :translate #f(0 -30 0))

  (send *viewer* :draw-objects)
  (warn "please run (c2-1)~%")
  )

(defun c2-1 ()
  (send *arrow* :newcoords (send *cut-point-2* :copy-worldcoords))

  (send *viewer* :draw-objects)
  (warn "please run (c2-2)~%")
  )


(defun c2-2 ()
  (send p4-1 :dissoc p2-1)
  (send p2-1 :translate #f(0 0 20))

  (send *viewer* :draw-objects)
  (warn "please run (c3-1)~%")
  )
  
(defun c3-1 ()
  (send *arrow* :newcoords (send *cut-point-3* :copy-worldcoords))

  (send *viewer* :draw-objects)
  (warn "please run (c3-2)~%")
  )


(defun c3-2 ()
  (send p4-1 :dissoc p6-1)
  (send p6-1 :translate #f(0 0 -20))

  (send *viewer* :draw-objects)
  (warn "please run (c4-1)~%")
  )

(defun c4-1 ()
  (send *arrow* :newcoords (send *cut-point-4* :copy-worldcoords))

  (send *viewer* :draw-objects)
  (warn "please run (c4-2)~%")
  )


(defun c4-2 ()
  (send p3-1 :dissoc p1-1)
  (send p1-1 :translate #f(0 0 20))

  (send *viewer* :draw-objects)
  (warn "please run (c5-1)~%")
  )

(defun c5-1 ()
  (send *arrow* :newcoords (send *cut-point-5* :copy-worldcoords))

  (send *viewer* :draw-objects)
  (warn "please run (c5-2)~%")
  )


(defun c5-2 ()
  (send p3-1 :dissoc p5-1)
  (send p5-1 :translate #f(0 0 -20))

  (send *viewer* :draw-objects)
  )

(defun exec-all ()
  (c1-1)
  (unix:usleep 1000000)
  (c1-2)
  (unix:usleep 1000000)
  (c2-1)
  (unix:usleep 1000000)
  (c2-2)
  (unix:usleep 1000000)
  (c3-1)
  (unix:usleep 1000000)
  (c3-2)
  (unix:usleep 1000000)
  (c4-1)
  (unix:usleep 1000000)
  (c4-2)
  (unix:usleep 1000000)
  (c5-1)
  (unix:usleep 1000000)
  (c5-2)
  (unix:usleep 1000000)
  )
