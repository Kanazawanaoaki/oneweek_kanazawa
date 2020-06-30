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

(defun body-cut-y (abody box)
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
	   (send box :locate #f(0 -1 0))
	   (setq i (+ i 1))
	   )

    (setq b2 (body- abody b1))
    (list b1 b2)))

(defun dev-2-y (abody)
  (let (b box b1 b2 m m2)
    (setq b (make-bounding-box (send abody :vertices)))

    (setq m (v- (send b :maxpoint) (send b :minpoint)))
    (setq m2 (v+ (send b :maxpoint) (send b :minpoint)))
    (setq m2 (float-vector (/ (elt m2 0) 2) (/ (elt m2 1) 2) (/ (elt m2 2) 2)))
    
    (setq box (make-cube (* (elt m 0) 2) (* (elt m 1) 2) (* (elt m 2) 2)))
    (send box :locate m2)
    (send box :locate (float-vector 0 (* 1 (elt m 1))  0))

    (body-cut-y abody box)))

(defun random-cut (abody)
  (let (b m box c  b-list b1 b2 b3 r)
    (setq b (make-bounding-box (send abody :vertices)))
    (setq m (v- (send b :maxpoint) (send b :minpoint)))
    
    (setq box (make-cube (* (elt m 0) 2) (* (elt m 1) 2) (* (elt m 2) 2)))
    (send box :locate (send b :center))
    (send box :translate (float-vector (* (elt m 0) -1) 0 0))
    (setq c (make-cascoords :pos (send b :center)))
    
    (send c :assoc box)
    (send c :translate (float-vector (/ (elt m 0) -2) 0 0) :world)

    (setq b1 abody)
    
    (send c :rotate (deg2rad 45) :z)
    (send c :translate #f(10 0 0) :world)
    (setq tmp (body-cut-x-with-c b1 box c))
    (setq b1 (elt tmp 0))
    (setq b2 (elt tmp 1))
    (push b2 r)

    (setq num (- (round (/ (elt m 0) 10)) 1)) 

    (dotimes (i num)
      (send c :rotate (deg2rad 90) :x :world)
      (send c :translate #f(10 0 0) :world)
      (setq tmp (body-cut-x-with-c b1 box c))
      (setq b1 (elt tmp 0))
      (setq b2 (elt tmp 1))
      (push b2 r))

    (push b1 r)

    r))


(setq v-list (list #f(100.0 -15.0 25.9808) #f(100.0 -25.9808 15.0) #f(100.0 -30.0 -4.085621e-14) #f(100.0 -25.9808 -15.0) #f(100.0 -15.0 -25.9808) #f(100.0 2.842171e-14 -30.0) #f(100.0 15.0 -25.9808) #f(100.0 25.9808 -15.0) #f(100.0 30.0 1.598721e-14) #f(100.0 25.9808 15.0) #f(100.0 15.0 25.9808) #f(100.0 0.0 30.0)))


(setq b2 (make-cone #f(-100 0 0) v-list))

(setq b3 (make-sphere 30))
(send b3 :locate #f(100 0 0))

(setq b4 (make-cube 100 100 100))
(send b4 :translate #f(49 0 0))
(setq c1 (body- b3 b4))

(setq b5 (make-cube 200 200 200))
(send b5 :translate #f(-70 0 0))
(setq c2 (body- b2 b5))

(setq t1 (body- b2 c2))
(send b5 :translate #f(-90 0 0))
(setq c3 (body- t1 b5))
(setq c4 (body- t1 c3))

;;;;;;
(setq b-list (random-cut c2))
(setq c2-1-1 (elt b-list 0))
(setq c2-1-2 (elt b-list 1))
(setq c2-1-3 (elt b-list 2))
(setq c2-1-4 (elt b-list 3))
(setq c2-1-5 (elt b-list 4))
(setq c2-1-6 (elt b-list 5))
(setq c2-1-7 (elt b-list 6))
(setq c2-1-8 (elt b-list 7))

(setq b-list (random-cut c3))
(setq c3-1-1 (elt b-list 0))
(setq c3-1-2 (elt b-list 1))
(setq c3-1-3 (elt b-list 2))
(setq c3-1-4 (elt b-list 3))
(setq c3-1-5 (elt b-list 4))
(setq c3-1-6 (elt b-list 5))
(setq c3-1-7 (elt b-list 6))
(setq c3-1-8 (elt b-list 7))
(setq c3-1-9 (elt b-list 8))
(setq c3-1-10 (elt b-list 9))

(send c2-1-1 :set-color :orangered)
(send c2-1-2 :set-color :orangered)
(send c2-1-3 :set-color :orangered)
(send c2-1-4 :set-color :orangered)
(send c2-1-5 :set-color :orangered)
(send c2-1-6 :set-color :orangered)
(send c2-1-7 :set-color :orangered)
(send c2-1-8 :set-color :orangered)

(send c2-1-1 :assoc c2-1-2)
(send c2-1-1 :assoc c2-1-3)
(send c2-1-1 :assoc c2-1-4)
(send c2-1-1 :assoc c2-1-5)
(send c2-1-1 :assoc c2-1-6)
(send c2-1-1 :assoc c2-1-7)
(send c2-1-1 :assoc c2-1-8)

(send c3-1-1 :set-color :orangered)
(send c3-1-2 :set-color :orangered)
(send c3-1-3 :set-color :orangered)
(send c3-1-4 :set-color :orangered)
(send c3-1-5 :set-color :orangered)
(send c3-1-6 :set-color :orangered)
(send c3-1-7 :set-color :orangered)
(send c3-1-8 :set-color :orangered)
(send c3-1-9 :set-color :orangered)
(send c3-1-10 :set-color :orangered)

(send c3-1-1 :assoc c3-1-2)
(send c3-1-1 :assoc c3-1-3)
(send c3-1-1 :assoc c3-1-4)
(send c3-1-1 :assoc c3-1-5)
(send c3-1-1 :assoc c3-1-6)
(send c3-1-1 :assoc c3-1-7)
(send c3-1-1 :assoc c3-1-8)
(send c3-1-1 :assoc c3-1-9)
(send c3-1-1 :assoc c3-1-10)

(send c1 :set-color :orangered)
(send c4 :set-color :orangered)

(setq *cut-point-1* (make-cascoords :pos #f(100 0 0)))
(send *cut-point-1* :rotate (deg2rad 90) :z)

(setq *cut-point-2* (make-cascoords :pos #f(30 0 0)))
(send *cut-point-2* :rotate (deg2rad 90) :z)

(setq *cut-point-3* (make-cascoords :pos #f(-60 0 0)))
(send *cut-point-3* :rotate (deg2rad 90) :z)
(send *cut-point-3* :rotate (deg2rad 180) :z :world)

(setq *cut-point-4* (make-cascoords :pos #f(65 0 -30)))

(send c2-1-1 :assoc *cut-point-1*)
(send c2-1-1 :assoc *cut-point-2*)
(send c3-1-1 :assoc *cut-point-3*)
(send c2-1-1 :assoc *cut-point-4*)

(send c2-1-1 :assoc c1)
(send c2-1-1 :assoc c3-1-1)
(send c3-1-1 :assoc c4)


(setq *carrot* (instance bodyset-link :init (make-cascoords) :bodies (list c2-1-1 c2-1-2 c2-1-3 c2-1-4 c2-1-5 c2-1-6 c2-1-7 c2-1-8 c1 c3-1-1 c3-1-2 c3-1-3 c3-1-4 c3-1-5 c3-1-6 c3-1-7 c3-1-8 c3-1-9 c3-1-10 c4) :weight 1 :centroid (float-vector 0.0 0.0 0.0) :inertia-tensor #2f((1.0 0.0 0.0) (0.0 1.0 0.0) (0.0 0.0 1.0))))


;; (setq *c-list-3* (list c3-1-1 c3-1-2 c3-1-3 c3-1-4 c3-1-5 c3-1-6 c3-1-7 c3-1-8 c3-1-9 c3-1-10))
;; (setq *c-list-2* (list c2-1-1 c2-1-2 c2-1-3 c2-1-4 c2-1-5 c2-1-6 c2-1-7 c2-1-8))


;; (setq leng (length *c-list-2*))
;; (dolist (x *c-list-2*)
;;   (send x :translate (float-vector (* leng 20) 0 0) :world)
;;   (send x :set-color :orangered)
;;   (setq leng (- leng 1))
;;   )

;; (objects *c-list-2*)

(objects (list *carrot*))

      
;;;
;; (setq *c-list-3* (list c3-1-1 c3-1-2 c3-1-3 c3-1-4 c3-1-5 c3-1-6 c3-1-7 c3-1-8 c3-1-9 c3-1-10))

;; (send c2-1-1 :dissoc c3-1-1)
;; (send c3-1-1 :dissoc c4)
;; (send c3-1-1 :translate #f(0 0 50) :world)
;; (send *viewer* :draw-objects)

;; (setq *tmp-list-3* (list c3-1-10 c3-1-9 c3-1-8 c3-1-7 c3-1-6 c3-1-5 c3-1-4 c3-1-3 c3-1-2))
;; (setq leng (length *tmp-list-3*))
;; (dolist (x *tmp-list-3*)
;;   (send c3-1-1 :dissoc x)
;;   (send x :translate (float-vector (* leng -10) 0 0) :world)
;;   (send c3-1-1 :rotate (deg2rad -90) :x :world)
;;   (setq leng (- leng 1))
;;   (send *viewer* :draw-objects)
;;   (unix:sleep 1)
;;   )


(setq *c-list-2* (list c2-1-1 c2-1-2 c2-1-3 c2-1-4 c2-1-5 c2-1-6 c2-1-7 c2-1-8))

(send c2-1-1 :dissoc c1)
(send c2-1-1 :dissoc c3-1-1)
(send c2-1-1 :translate #f(0 0 50) :world)
(send *viewer* :draw-objects)

(setq *tmp-list-3* (list c2-1-8 c2-1-7 c2-1-6 c2-1-5 c2-1-4 c2-1-3 c2-1-2))
(setq leng (length *tmp-list-3*))
(dolist (x *tmp-list-3*)
  (send c2-1-1 :dissoc x)
  (send x :translate (float-vector (* leng -15) 0 0) :world)
  (send c2-1-1 :rotate (deg2rad -90) :x :world)
  (setq leng (- leng 1))
  (send *viewer* :draw-objects)
  (unix:sleep 1)
  )



;;;;;;;
;; (setq *carrot* (carrot))
;; (send *carrot* :translate #f(0 0 50))

;; (send *carrot* :cut)

;; ;; set arrow
;; (load "models/arrow-object.l")
;; (setq *arrow* (arrow))

;; (objects (list *carrot* *arrow*))

;; (send *viewer* :draw-objects)

;; (warn "please run (f-cut1-1)~%")
;; (warn "you can also run (now-devel) or (exec-all)~%")

;; (defun f-cut1-1 ()
;;   (send *arrow* :newcoords (send *cut-point-1* :copy-worldcoords))

;;   (send *viewer* :draw-objects)
;;   (warn "please run (f-cut1-2)~%")
;;   )

;; (defun f-cut1-2 ()
;;   (send c2-1-1 :dissoc c1)
;;   (send c1 :translate #f(30 0 0))

;;   (send *viewer* :draw-objects)
;;   (warn "please run (f-cut2-1)~%")
;;   )

;; (defun f-cut2-1 ()
;;   (send *arrow* :newcoords (send *cut-point-2* :copy-worldcoords))

;;   (send *viewer* :draw-objects)
;;   (warn "please run (f-cut2-2)~%")
;;   )

;; (defun f-cut2-2 ()
;;   (send c2-1-1 :dissoc c3-1-1)
;;   (send c2-1-1 :translate #f(20 0 0))

;;   (send *viewer* :draw-objects)
;;   (warn "please run (f-cut3-1)~%")
;;   )

;; (defun f-cut3-1 ()
;;   (send *arrow* :newcoords (send *cut-point-3* :copy-worldcoords))

;;   (send *viewer* :draw-objects)
;;   (warn "please run (f-cut3-2)~%")
;;   )

;; (defun f-cut3-2 ()
;;   (send c3-1-1 :dissoc c4)
;;   (send c4 :translate #f(-20 0 0))

;;   (send *viewer* :draw-objects)
;;   (warn "please run (cut1-1)~%")
;;   )

;; (defun cut1-1 ()
;;   (send *arrow* :newcoords (send *cut-point-4* :copy-worldcoords))

;;   (send *viewer* :draw-objects)
;;   (warn "please run (cut1-2)~%")
;;   )

;; (defun cut1-2 ()
;;   (send c2-1-1 :dissoc c2-2-1)
;;   (send c2-1-1 :translate #f(0 -20 0))

;;   (send *viewer* :draw-objects)
;;   (warn "please run (cut2-1)~%")
;;   )

;; (defun cut2-1 ()
;;   (send c2-1-1 :dissoc c2-1-2)
;;   (send c2-1-1 :dissoc c2-1-3)
;;   (send c2-1-1 :dissoc c2-1-4)
;;   (send c2-1-1 :dissoc c2-1-5)
;;   (send c2-1-1 :dissoc c2-1-6)
;;   (send c2-1-1 :dissoc c2-1-7)


;;   (send c2-1-1 :locate #f(-30 0 0))
;;   (send c2-1-2 :locate #f(-20 0 0))
;;   (send c2-1-3 :locate #f(-10 0 0))
;;   (send c2-1-4 :locate #f(0 0 0))
;;   (send c2-1-5 :locate #f(10 0 0))
;;   (send c2-1-6 :locate #f(20 0 0))
;;   (send c2-1-7 :locate #f(30 0 0))

;;   (send *viewer* :draw-objects)
;;   (warn "please run (cut2-2)~%")
;;   )

;; (defun cut2-2 ()
;;   (send c2-2-1 :dissoc c2-2-2)
;;   (send c2-2-1 :dissoc c2-2-3)
;;   (send c2-2-1 :dissoc c2-2-4)
;;   (send c2-2-1 :dissoc c2-2-5)
;;   (send c2-2-1 :dissoc c2-2-6)
;;   (send c2-2-1 :dissoc c2-2-7)


;;   (send c2-2-1 :locate #f(-30 0 0))
;;   (send c2-2-2 :locate #f(-20 0 0))
;;   (send c2-2-3 :locate #f(-10 0 0))
;;   (send c2-2-4 :locate #f(0 0 0))
;;   (send c2-2-5 :locate #f(10 0 0))
;;   (send c2-2-6 :locate #f(20 0 0))
;;   (send c2-2-7 :locate #f(30 0 0))

;;   (send *viewer* :draw-objects)
;;   )




;; (defun now-devel ()
;;   (f-cut1-1)
;;   (f-cut1-2)
;;   (f-cut2-1)
;;   (f-cut2-2)
;;   (f-cut3-1)
;;   (f-cut3-2)

;;   (unix:sleep 1)
;;   (send *carrot* :translate #f(0 0 50))
;;   (send *viewer* :draw-objects)  
;;   )




;; (defun exec-all ()
;;   (f-cut1-1)
;;   (unix:usleep 1000000)
;;   (f-cut1-2)
;;   (unix:usleep 1000000)
;;   (f-cut2-1)
;;   (unix:usleep 1000000)
;;   (f-cut2-2)
;;   (unix:usleep 1000000)
;;   (f-cut3-1)
;;   (unix:usleep 1000000)
;;   (f-cut3-2)

;;   (unix:sleep 1)
;;   (send *carrot* :translate #f(0 0 50))
;;   (send *viewer* :draw-objects)
;;   (unix:usleep 1000000)

;;   (cut1-1)
;;   (unix:usleep 1000000)
;;   (cut1-2)
;;   (unix:usleep 1000000)
;;   (cut2-1)
;;   (unix:usleep 1000000)
;;   (cut2-2)
;;   )

