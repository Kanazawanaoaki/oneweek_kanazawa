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

(setq width 90)
(setq length 90)
(setq height 70)

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

(setq b3 (make-cube (* 2 width) (* 2 length) (* 2 height)))
(send b3 :locate (float-vector (/ width -2) 0 0))

(send b3 :locate #f(-10 0 0))
(setq p3-3-1 (body- p3-1 b3))
(setq p3-1 (body- p3-1 p3-3-1))
(setq p4-3-1 (body- p4-1 b3))
(setq p4-1 (body- p4-1 p4-3-1))

(send b3 :locate #f(-10 0 0))
(setq p3-3-2 (body- p3-1 b3))
(setq p3-1 (body- p3-1 p3-3-2))
(setq p4-3-2 (body- p4-1 b3))
(setq p4-1 (body- p4-1 p4-3-2))

(send b3 :locate #f(-10 0 0))
(setq p3-3-3 (body- p3-1 b3))
(setq p3-1 (body- p3-1 p3-3-3))
(setq p4-3-3 (body- p4-1 b3))
(setq p4-1 (body- p4-1 p4-3-3))

(send b3 :locate #f(-10 0 0))
(setq p3-3-4 (body- p3-1 b3))
(setq p3-1 (body- p3-1 p3-3-4))
(setq p4-3-4 (body- p4-1 b3))
(setq p4-1 (body- p4-1 p4-3-4))

(send b3 :locate #f(-10 0 0))
(setq p3-3-5 (body- p3-1 b3))
(setq p3-1 (body- p3-1 p3-3-5))
(setq p4-3-5 (body- p4-1 b3))
(setq p4-1 (body- p4-1 p4-3-5))

(send b3 :locate #f(-10 0 0))
(setq p3-3-6 (body- p3-1 b3))
(setq p3-1 (body- p3-1 p3-3-6))
(setq p4-3-6 (body- p4-1 b3))
(setq p4-1 (body- p4-1 p4-3-6))

(send b3 :locate #f(-10 0 0))
(setq p3-3-7 (body- p3-1 b3))
(setq p3-1 (body- p3-1 p3-3-7))
(setq p4-3-7 (body- p4-1 b3))
(setq p4-1 (body- p4-1 p4-3-7))

(send b3 :locate #f(-10 0 0))
(setq p3-3-8 (body- p3-1 b3))
(setq p3-1 (body- p3-1 p3-3-8))
(setq p4-3-8 (body- p4-1 b3))
(setq p4-1 (body- p4-1 p4-3-8))

(send p3-3-1 :locate #f(30 0 0))
(send p3-3-2 :locate #f(20 0 0))
(send p3-3-3 :locate #f(10 0 0))

(send p3-3-8 :locate #f(0 0 10))

(objects (list p3-1 p4-1 p3-3-1 p4-3-1 p3-3-2 p4-3-2 p3-3-3 p4-3-3 p3-3-4 p4-3-4 p3-3-5 p4-3-5 p3-3-6 p4-3-6 p3-3-7 p4-3-7 p3-3-8 p4-3-8))




;; (send p1-1 :assoc p1-2)
;; (send p1-1 :assoc p1-3)
;; (send p1-1 :assoc p1-4)
;; (send p2-1 :assoc p2-2)
;; (send p2-1 :assoc p2-3)
;; (send p2-1 :assoc p2-4)
;; (send p3-1 :assoc p3-2)
;; (send p4-1 :assoc p4-2)
;; (send p5-1 :assoc p5-2)
;; (send p6-1 :assoc p6-2)

;; ;; set colors
;; (send p1-2 :set-color :peru)
;; (send p1-4 :set-color :peru)
;; (send p2-2 :set-color :peru)
;; (send p2-4 :set-color :peru)
;; (send p3-2 :set-color :peru)
;; (send p4-2 :set-color :peru)
;; (send p5-2 :set-color :peru)
;; (send p6-2 :set-color :peru)


;; (send p1-1 :set-color :beige)
;; (send p1-3 :set-color :beige)
;; (send p2-1 :set-color :beige)
;; (send p2-3 :set-color :beige)
;; (send p3-1 :set-color :beige)
;; (send p4-1 :set-color :beige)
;; (send p5-1 :set-color :beige)
;; (send p6-1 :set-color :beige)

;; (setq *cut-point-1* (make-cascoords :pos (float-vector 0 0 (* -1 (/ height 2)))))
;; (setq *cut-point-2* (make-cascoords :pos (float-vector 0 0 (* 1 (/ height 3)))))
;; (send *cut-point-2* :rotate (deg2rad -90) :x)
;; (send *cut-point-2* :rotate (deg2rad 180) :z :world)
;; (setq *cut-point-3* (make-cascoords :pos (float-vector 0 0 (* -1 (/ height 3)))))
;; (send *cut-point-3* :rotate (deg2rad -90) :x)
;; (send *cut-point-3* :rotate (deg2rad 180) :z :world)
;; (send *cut-point-3* :rotate (deg2rad 180) :z)

;; (setq *cut-point-4* (make-cascoords :pos (float-vector 0 0 (* 1 (/ height 3)))))
;; (send *cut-point-4* :rotate (deg2rad -90) :x)
;; (setq *cut-point-5* (make-cascoords :pos (float-vector 0 0 (* -1 (/ height 3)))))
;; (send *cut-point-5* :rotate (deg2rad -90) :x)
;; (send *cut-point-5* :rotate (deg2rad 180) :z)

;; (send p3-1 :assoc *cut-point-1*)
;; (send p2-1 :assoc *cut-point-2*)
;; (send p4-1 :assoc *cut-point-3*)
;; (send p1-1 :assoc *cut-point-4*)
;; (send p3-1 :assoc *cut-point-5*)

;; (send p4-1 :assoc p2-1)
;; (send p4-1 :assoc p6-1)
;; (send p3-1 :assoc p1-1)
;; (send p3-1 :assoc p5-1)
;; (send p3-1 :assoc p4-1)

;; (setq *onion* (instance bodyset-link :init (make-cascoords) :bodies (list p3-1 p3-2 p1-1 p1-2 p1-3 p1-4 p5-1 p5-2 p2-1 p2-2 p2-3 p2-4 p4-1 p4-2 p6-1 p6-2) :weight 1 :centroid (float-vector 0.0 0.0 0.0) :inertia-tensor #2f((1.0 0.0 0.0) (0.0 1.0 0.0) (0.0 0.0 1.0))))

;; ;; set arrow
;; (load "models/arrow-object.l")
;; (setq *arrow* (arrow))

;; (objects (list *onion* *arrow*))

;; (send *viewer* :draw-objects)



(warn "please run (p1-1) or (exec-all)~%")

(defun p1-1 ()
  (send *arrow* :newcoords (send *cut-point-1* :copy-worldcoords))

  (send *viewer* :draw-objects)
  (warn "please run (p1-2)~%")
  )

(defun p1-2 ()
  (send p3-1 :dissoc p4-1)
  (send p4-1 :translate #f(0 -30 0))

  (send *viewer* :draw-objects)
  (warn "please run (p2-1)~%")
  )

(defun p2-1 ()
  (send *arrow* :newcoords (send *cut-point-2* :copy-worldcoords))

  (send *viewer* :draw-objects)
  (warn "please run (p2-2)~%")
  )


(defun p2-2 ()
  (send p4-1 :dissoc p2-1)
  (send p2-1 :translate #f(0 0 20))

  (send *viewer* :draw-objects)
  (warn "please run (p3-1)~%")
  )
  
(defun p3-1 ()
  (send *arrow* :newcoords (send *cut-point-3* :copy-worldcoords))

  (send *viewer* :draw-objects)
  (warn "please run (p3-2)~%")
  )


(defun p3-2 ()
  (send p4-1 :dissoc p6-1)
  (send p6-1 :translate #f(0 0 -20))

  (send *viewer* :draw-objects)
  (warn "please run (p4-1)~%")
  )

(defun p4-1 ()
  (send *arrow* :newcoords (send *cut-point-4* :copy-worldcoords))

  (send *viewer* :draw-objects)
  (warn "please run (p4-2)~%")
  )


(defun p4-2 ()
  (send p3-1 :dissoc p1-1)
  (send p1-1 :translate #f(0 0 20))

  (send *viewer* :draw-objects)
  (warn "please run (p5-1)~%")
  )

(defun p5-1 ()
  (send *arrow* :newcoords (send *cut-point-5* :copy-worldcoords))

  (send *viewer* :draw-objects)
  (warn "please run (p5-2)~%")
  )


(defun p5-2 ()
  (send p3-1 :dissoc p5-1)
  (send p5-1 :translate #f(0 0 -20))

  (send *viewer* :draw-objects)
  (warn "please run (p6-1)~%")
  )

(defun p6-1 ()
  (send p4-1 :dissoc p4-2)
  (send p4-2 :translate #f(0 -50 0))

  (send *viewer* :draw-objects)
  (warn "please run (p6-2)~%")
  )


(defun p6-2 ()
  (send p3-1 :dissoc p3-2)
  (send p3-2 :translate #f(0 50 0))

  (send *viewer* :draw-objects)
  )


(defun exec-all ()
  (p1-1)
  (unix:usleep 1000000)
  (p1-2)
  (unix:usleep 1000000)
  (p2-1)
  (unix:usleep 1000000)
  (p2-2)
  (unix:usleep 1000000)
  (p3-1)
  (unix:usleep 1000000)
  (p3-2)
  (unix:usleep 1000000)
  (p4-1)
  (unix:usleep 1000000)
  (p4-2)
  (unix:usleep 1000000)
  (p5-1)
  (unix:usleep 1000000)
  (p5-2)
  (unix:usleep 1000000)
  (p6-1)
  (unix:usleep 1000000)
  (p6-2)
  )
