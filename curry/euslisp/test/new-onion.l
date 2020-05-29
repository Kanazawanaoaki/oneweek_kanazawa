(defun z-mul (point num)
  (float-vector (elt point 0) (elt point 1) (* (elt point 2) num)))

;; definition of basic bodies

(setq b1 (make-sphere 45))
(setq v-list (list (z-mul (car (send b1 :vertices)) 0.78)))
(dolist (x (cdr (send b1 :vertices))) (setq v-list (append v-list (list (z-mul x 0.78)))))
(setq b2 (convex-hull-3d v-list))

(setq b1 (make-sphere 44))
(setq v-list (list (z-mul (car (send b1 :vertices)) 0.78)))
(dolist (x (cdr (send b1 :vertices))) (setq v-list (append v-list (list (z-mul x 0.78)))))
(setq b1 (convex-hull-3d v-list))

;; b1 is inside elliptical sphere, and b2 is leather of onion.
(setq b2 (body- b2 b1))
(send b1 :assoc b2)

;; (setq b3 (make-cylinder 8 2))
;; (setq v-list (list (car (send b3 :vertices))))
;; (dolist (x (cdr (send b3 :vertices))) (if (< (elt x 2) 1) (setq v-list (append v-list (list x)))))
(setq v-list (list #f(6.9282 -4.0 0.0) #f(4.0 -6.9282 0.0) #f(-1.376677e-14 -8.0 0.0) #f(-4.0 -6.9282 0.0) #f(-6.9282 -4.0 0.0) #f(-8.0 8.437695e-15 0.0) #f(-6.9282 4.0 0.0) #f(-4.0 6.9282 0.0) #f(3.996803e-15 8.0 0.0) #f(4.0 6.9282 0.0) #f(6.9282 4.0 0.0) #f(8.0 0.0 0.0)))
(setq b4 (make-cone #f(0 0 20) v-list))
(send b4 :translate #f(0 0 28))

;; (setq b3 (make-cylinder 7 2))
;; (setq v-list (list (car (send b3 :vertices))))
;; (dolist (x (cdr (send b3 :vertices))) (if (< (elt x 2) 1) (setq v-list (append v-list (list x)))))
(setq v-list (list #f(6.06218 -3.5 0.0) #f(3.5 -6.06218 0.0) #f(-1.110223e-14 -7.0 0.0) #f(-3.5 -6.06218 0.0) #f(-6.06218 -3.5 0.0) #f(-7.0 7.105427e-15 0.0) #f(-6.06218 3.5 0.0) #f(-3.5 6.062 0.0) #f(3.552714e-15 7.0 0.0) #f(3.5 6.06218 0.0) #f(6.06218 3.5 0.0) #f(7.0 0.0 0.0)))
(setq b3 (make-cone #f(0 0 19) v-list))
(send b3 :translate #f(0 0 28))

;; b3 is inside cone, and b4 is leather of onion.
(setq b4 (body- b4 b3))
(send b3 :assoc b4)

(objects (list b4 b3))

(send b1 :assoc b3)

;; b5 is cube for body-
(setq b5 (make-cube 100 100 100))
(send b5 :translate #f(0 -50 0))

(send b1 :translate #f(0 1 0))

;; definiton tmp bodies
(setq t1-1 (body- b1 b5))
(setq t1-2 (body- b2 b5))
(setq t1-3 (body- b3 b5))
(setq t1-4 (body- b4 b5))

(setq t2-1 (body- b1 t1-1))
(setq t2-2 (body- b2 t1-2))
(setq t2-3 (body- b3 t1-3))
(setq t2-4 (body- b4 t1-4))

(send b5 :translate #f(0 50 -25))

;; start making parts of onion
(setq p1-1 (body- t1-1 b5))
(setq p1-2 (body- t1-2 b5))
(setq t3-1 (body- t1-1 p1-1))
(setq t3-2 (body- t1-2 p1-2))
(setq p1-3 t1-3)
(setq p1-4 t1-4)
(send p1-1 :assoc p1-2)
(send p1-1 :assoc p1-3)
(send p1-3 :assoc p1-4)

(setq p2-1 (body- t2-1 b5))
(setq p2-2 (body- t2-2 b5))
(setq t4-1 (body- t2-1 p2-1))
(setq t4-2 (body- t2-2 p2-2))
(setq p2-3 t2-3)
(setq p2-4 t2-4)
(send p2-1 :assoc p2-2)
(send p2-1 :assoc p2-3)
(send p2-3 :assoc p2-4)

(send b5 :translate #f(0 0 -50))

(setq p3-1 (body- t3-1 b5))
(setq p3-2 (body- t3-2 b5))
(setq p5-1 (body- t3-1 p3-1))
(setq p5-2 (body- t3-2 p3-2))
(send p3-1 :assoc p3-2)
(send p5-1 :assoc p5-2)

(setq p4-1 (body- t4-1 b5))
(setq p4-2 (body- t4-2 b5))
(setq p6-1 (body- t4-1 p4-1))
(setq p6-2 (body- t4-2 p4-2))
(send p4-1 :assoc p4-2)
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

(setq *cut-point-1* (make-cascoords :pos #f(0 0 -30)))
(setq *cut-point-2* (make-cascoords :pos #f(0 0 25)))
(send *cut-point-2* :rotate (deg2rad -90) :x)
(send *cut-point-2* :rotate (deg2rad 180) :z :world)
(setq *cut-point-3* (make-cascoords :pos #f(0 0 -25)))
(send *cut-point-3* :rotate (deg2rad -90) :x)
(send *cut-point-3* :rotate (deg2rad 180) :z :world)

(setq *cut-point-4* (make-cascoords :pos #f(0 0 25)))
(send *cut-point-4* :rotate (deg2rad -90) :x)
(setq *cut-point-5* (make-cascoords :pos #f(0 0 -25)))
(send *cut-point-5* :rotate (deg2rad -90) :x)

(load "models/arrow-object.l")
(setq *arrow* (arrow))
(send *arrow* :move-to *cut-point-1* :world)

(objects (list p1-1 p1-2 p1-3 p1-4 p2-1 p2-2 p2-3 p2-4 p3-1 p3-2 p4-1 p4-2 p5-1 p5-2 p6-1 p6-2 *arrow*))
