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


(defun body-cut-x-with-c (abody box coords)
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
	   (send coords :locate #f(-1 0 0))
	   (setq i (+ i 1))
	   )

    (setq b2 (body- abody b1))
    (list b1 b2)))


(setq width 90)
(setq length 90)
(setq height 60)


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
(setq o1-4 (body- b6 b3))
(setq o2-4 (body- b6 o1-4))
(setq o1-3 (body- b7 b3))
(setq o2-3 (body- b7 o1-3))

(setq b3 (make-cube (* 2 width) (* 2 length) (* 2 height)))
(send b3 :locate (float-vector 0 0 (* (/ height 3) -2)))

(setq o2-1 (body- b2 b3))
(setq b2 (body- b2 o2-1))
(setq o2-2 (body- b1 b3))
(setq b1 (body- b1 o2-2))
(setq o1-1 (body- b5 b3))
(setq b5 (body- b5 o1-1))
(setq o1-2 (body- b4 b3))
(setq b4 (body- b4 o1-2))

(send b3 :locate (float-vector 0 0 (* (/ height 3) -2)))

(setq o4-1 (body- b2 b3))
(setq o6-1 (body- b2 o4-1))
(setq o4-2 (body- b1 b3))
(setq o6-2 (body- b1 o4-2))
(setq o3-1 (body- b5 b3))
(setq o5-1 (body- b5 o3-1))
(setq o3-2 (body- b4 b3))
(setq o5-2 (body- b4 o3-2))

(setq b3 (make-cube (* 2 width) (* 2 length) (* 2 height)))
(send b3 :locate (float-vector (* width -1) 0 0))
(setq b3-coords (make-cascoords))
(send b3-coords :assoc b3)
(setq b4 (make-cube (* 2 width) (* 2 length) (* 2 height)))
(send b4 :locate (float-vector (* width -1) 0 0))
(setq b4-coords (make-cascoords))
(send b4-coords :assoc b4)

(send b3-coords :rotate (deg2rad -45) :z)
(setq tmp (body-cut-x-with-c o3-1 b3 b3-coords))
(setq o3-3-1 (elt tmp 0))
(setq o3-1 (elt tmp 1))
(send b4-coords :rotate (deg2rad 45) :z)
(setq tmp (body-cut-x-with-c o4-1 b4 b4-coords))
(setq o4-3-1 (elt tmp 0))
(setq o4-1 (elt tmp 1))

(send b3-coords :rotate (deg2rad 45) :z)
(setq tmp (body-cut-x-with-c o3-1 b3 b3-coords))
(setq o3-3-2 (elt tmp 0))
(setq o3-1 (elt tmp 1))
(send b4-coords :rotate (deg2rad -45) :z)
(setq tmp (body-cut-x-with-c o4-1 b4 b4-coords))
(setq o4-3-2 (elt tmp 0))
(setq o4-1 (elt tmp 1))

(send b3-coords :rotate (deg2rad 45) :z)
(setq tmp (body-cut-x-with-c o3-1 b3 b3-coords))
(setq o3-3-3 (elt tmp 0))
(setq o3-1 (elt tmp 1))
(send b4-coords :rotate (deg2rad -45) :z)
(setq tmp (body-cut-x-with-c o4-1 b4 b4-coords))
(setq o4-3-3 (elt tmp 0))
(setq o4-1 (elt tmp 1))

(send o1-1 :assoc o1-2)
(send o1-1 :assoc o1-3)
(send o1-1 :assoc o1-4)
(send o2-1 :assoc o2-2)
(send o2-1 :assoc o2-3)
(send o2-1 :assoc o2-4)
(send o3-1 :assoc o3-2)
(send o4-1 :assoc o4-2)
(send o5-1 :assoc o5-2)
(send o6-1 :assoc o6-2)

(send o3-1 :assoc o3-3-1)
(send o3-1 :assoc o3-3-2)
(send o3-1 :assoc o3-3-3)
(send o4-1 :assoc o4-3-1)
(send o4-1 :assoc o4-3-2)
(send o4-1 :assoc o4-3-3)

;; ;; set colors
(send o1-2 :set-color :peru)
(send o1-4 :set-color :peru)
(send o2-2 :set-color :peru)
(send o2-4 :set-color :peru)
(send o3-2 :set-color :peru)
(send o4-2 :set-color :peru)
(send o5-2 :set-color :peru)
(send o6-2 :set-color :peru)


(send o1-1 :set-color :beige)
(send o1-3 :set-color :beige)
(send o2-1 :set-color :beige)
(send o2-3 :set-color :beige)
(send o3-1 :set-color :beige)
(send o4-1 :set-color :beige)
(send o5-1 :set-color :beige)
(send o6-1 :set-color :beige)

(send o3-1 :set-color :beige)
(send o3-3-1 :set-color :beige)
(send o3-3-2 :set-color :beige)
(send o3-3-3 :set-color :beige)
(send o4-1 :set-color :beige)
(send o4-3-1 :set-color :beige)
(send o4-3-2 :set-color :beige)
(send o4-3-3 :set-color :beige)

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

(send o3-1 :assoc *cut-point-1*)
(send o2-1 :assoc *cut-point-2*)
(send o4-1 :assoc *cut-point-3*)
(send o1-1 :assoc *cut-point-4*)
(send o3-1 :assoc *cut-point-5*)

(send o4-1 :assoc o2-1)
(send o4-1 :assoc o6-1)
(send o3-1 :assoc o1-1)
(send o3-1 :assoc o5-1)
(send o3-1 :assoc o4-1)


(setq *onion* (instance bodyset-link :init (make-cascoords) :bodies (list o3-1 o3-2 o1-1 o1-2 o1-3 o1-4 o5-1 o5-2 o2-1 o2-2 o2-3 o2-4 o4-1 o4-2 o6-1 o6-2 o3-3-1 o3-3-2 o3-3-3 o4-3-1 o4-3-2 o4-3-3) :weight 1 :centroid (float-vector 0.0 0.0 0.0) :inertia-tensor #2f((1.0 0.0 0.0) (0.0 1.0 0.0) (0.0 0.0 1.0))))



;; cut part visulaization
(setq *o-list-3* (list o3-3-1 o3-3-2 o3-3-3 o3-1))
(setq *o-list-4* (list o4-3-1 o4-3-2 o4-3-3 o4-1))

(setq leng (length *o-list-3*))
(dolist (x *o-list-3*)
  (send x :translate (float-vector (* leng 10) 10 0) :world)
  (setq leng (- leng 1))
  )

(setq leng (length *o-list-4*))
(dolist (x *o-list-4*)
  (send x :translate (float-vector (* leng 10) -10 0) :world)
  (setq leng (- leng 1))
  )


(objects (append *o-list-3* *o-list-4*))




;; ;; peel part test
;; (load "models/arrow-object.l")
;; (setq *arrow* (arrow))
;; (send *arrow* :move-to *cut-point-1* :world)

;; ;; (objects (list p1-1 p1-2 p1-3 p1-4 p2-1 p2-2 p2-3 p2-4 p3-1 p3-2 p4-1 p4-2 p5-1 p5-2 p6-1 p6-2 *arrow*))
;; (objects (list *onion* *arrow*))


;; (warn "please run (c1-1) or (exec-all)~%")

;; (defun c1-1 ()
;;   (send *arrow* :newcoords (send *cut-point-1* :copy-worldcoords))

;;   (send *viewer* :draw-objects)
;;   (warn "please run (c1-2)~%")
;;   )

;; (defun c1-2 ()
;;   (send o3-1 :dissoc o4-1)
;;   (send o4-1 :translate #f(0 -30 0))

;;   (send *viewer* :draw-objects)
;;   (warn "please run (c2-1)~%")
;;   )

;; (defun c2-1 ()
;;   (send *arrow* :newcoords (send *cut-point-2* :copy-worldcoords))

;;   (send *viewer* :draw-objects)
;;   (warn "please run (c2-2)~%")
;;   )


;; (defun c2-2 ()
;;   (send o4-1 :dissoc o2-1)
;;   (send o2-1 :translate #f(0 0 20))

;;   (send *viewer* :draw-objects)
;;   (warn "please run (c3-1)~%")
;;   )
  
;; (defun c3-1 ()
;;   (send *arrow* :newcoords (send *cut-point-3* :copy-worldcoords))

;;   (send *viewer* :draw-objects)
;;   (warn "please run (c3-2)~%")
;;   )


;; (defun c3-2 ()
;;   (send o4-1 :dissoc o6-1)
;;   (send o6-1 :translate #f(0 0 -20))

;;   (send *viewer* :draw-objects)
;;   (warn "please run (c4-1)~%")
;;   )

;; (defun c4-1 ()
;;   (send *arrow* :newcoords (send *cut-point-4* :copy-worldcoords))

;;   (send *viewer* :draw-objects)
;;   (warn "please run (c4-2)~%")
;;   )


;; (defun c4-2 ()
;;   (send o3-1 :dissoc o1-1)
;;   (send o1-1 :translate #f(0 0 20))

;;   (send *viewer* :draw-objects)
;;   (warn "please run (c5-1)~%")
;;   )

;; (defun c5-1 ()
;;   (send *arrow* :newcoords (send *cut-point-5* :copy-worldcoords))

;;   (send *viewer* :draw-objects)
;;   (warn "please run (c5-2)~%")
;;   )


;; (defun c5-2 ()
;;   (send o3-1 :dissoc o5-1)
;;   (send o5-1 :translate #f(0 0 -20))

;;   (send *viewer* :draw-objects)
;;   )

;; (defun exec-all ()
;;   (c1-1)
;;   (unix:usleep 1000000)
;;   (c1-2)
;;   (unix:usleep 1000000)
;;   (c2-1)
;;   (unix:usleep 1000000)
;;   (c2-2)
;;   (unix:usleep 1000000)
;;   (c3-1)
;;   (unix:usleep 1000000)
;;   (c3-2)
;;   (unix:usleep 1000000)
;;   (c4-1)
;;   (unix:usleep 1000000)
;;   (c4-2)
;;   (unix:usleep 1000000)
;;   (c5-1)
;;   (unix:usleep 1000000)
;;   (c5-2)
;;   (unix:usleep 1000000)
;;   )
