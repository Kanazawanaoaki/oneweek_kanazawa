(defun x-mul (point num)
  (float-vector (* (elt point 0) num) (elt point 1) (elt point 2)))

(setq b1 (make-sphere 30))
(setq v-list (list (x-mul (car (send b1 :vertices)) 1.5)))
(dolist (x (cdr (send b1 :vertices))) (setq v-list (append v-list (list (x-mul x 1.5)))))
(setq b2 (convex-hull-3d v-list))
     
(setq b3 (make-cube 500 500 500))
(send b3 :translate #f(-250 0 0))
(setq b4 (make-cube 500 500 500))
(send b4 :translate #f(250 0 0))

(send b2 :translate #f(1 0 0))

(setq b5 (make-cube 500 500 500))
(send b5 :translate #f(0 0 -240))

(setq b6 (make-cube 500 500 500))
(send b6 :translate #f(0 0 -260))

(setq t1 (body- b2 b3))
(setq t2 (body- b2 b4))

(setq p1 (body- t1 b5))
(setq t3 (body- t1 p1))
(setq p2 (body- t3 b6))
(setq p3 (body- t3 p2))

(setq p4 (body- t2 b5))
(setq t4 (body- t2 p4))
(setq p5 (body- t4 b6))
(setq p6 (body- t4 p5))

(send p1 :set-color :moccasin)
(send p2 :set-color :moccasin)
(send p3 :set-color :moccasin)
(send p4 :set-color :moccasin)
(send p5 :set-color :moccasin)
(send p6 :set-color :moccasin)

(setq *potato* (make-cascoords))
(send *potato* :assoc p1)
(send *potato* :assoc p2)
(send *potato* :assoc p3)
(send *potato* :assoc p4)
(send *potato* :assoc p5)
(send *potato* :assoc p6)

(setq *cut-point-1* (make-cascoords))
(send *cut-point-1* :rotate (deg2rad 90) :z)
(send *potato* :assoc *cut-point-1*)

(setq *cut-point-2* (make-cascoords :pos #f(0 0 -10)))
(send *cut-point-2* :rotate (deg2rad 90) :y)
(send *cut-point-2* :rotate (deg2rad 90) :z)
(send p2 :assoc *cut-point-2*)

(setq *cut-point-3* (make-cascoords :pos #f(0 0 10)))
(send *cut-point-3* :rotate (deg2rad 90) :y)
(send *cut-point-3* :rotate (deg2rad 90) :z)
(send p1 :assoc *cut-point-3*)

(setq *cut-point-4* (make-cascoords :pos #f(0 0 -10)))
(send *cut-point-4* :rotate (deg2rad -90) :z)
(send *cut-point-4* :rotate (deg2rad 90) :x)
(send p5 :assoc *cut-point-4*)

(setq *cut-point-5* (make-cascoords :pos #f(0 0 10)))
(send *cut-point-5* :rotate (deg2rad -90) :z)
(send *cut-point-5* :rotate (deg2rad 90) :x)
(send p4 :assoc *cut-point-5*)


(load "models/arrow-object.l")
(setq *arrow* (arrow))
(send *arrow* :newcoords (send *cut-point-1* :copy-worldcoords))

(objects (list p1 p2 p3 p4 p5 p6 *arrow*))

(defun cut1 ()
  (send *arrow* :newcoords (send *cut-point-1* :copy-worldcoords))
  
  (send *potato* :dissoc p1)
  (send *potato* :dissoc p2)
  (send *potato* :dissoc p3)

  (setq *potato2* (make-cascoords))
  (send *potato2* :newcoords (send *potato* :copy-worldcoords))

  (send *potato2* :assoc p1)
  (send *potato2* :assoc p2)
  (send *potato2* :assoc p3)

  (send *potato2* :translate #f(30 0 0) :world)
  (send *viewer* :draw-objects)
  )

(defun cut2 ()
  (send *arrow* :newcoords (send *cut-point-2* :copy-worldcoords))
  (send *viewer* :draw-objects)

  (send *potato2* :dissoc p3)

  (send p3 :translate #f(0 0 -20))
  (send *viewer* :draw-objects)
  )

(defun cut3 ()
  (send *arrow* :newcoords (send *cut-point-3* :copy-worldcoords))
  (send *viewer* :draw-objects)

  (send *potato2* :dissoc p2)

  (send p2 :translate #f(0 0 -10))
  (send *viewer* :draw-objects)
  )

(defun cut4 ()
  (send *arrow* :newcoords (send *cut-point-4* :copy-worldcoords))
  (send *viewer* :draw-objects)

  (send *potato* :dissoc p6)

  (send p6 :translate #f(0 0 -20))
  (send *viewer* :draw-objects)
  )

(defun cut5 ()
  (send *arrow* :newcoords (send *cut-point-5* :copy-worldcoords))
  (send *viewer* :draw-objects)

  (send *potato* :dissoc p5)

  (send p5 :translate #f(0 0 -10))
  (send *viewer* :draw-objects)
  )




(defun pqp-test (&optional (close? t)
                                (p (list #f(15 0 0) #f(15 120 0) #f(-15 120 0) #f(-15 0 0) #f(-120 0 0) #f(-120 -30 0) #f(120 -30 0) #f(120 0 0))))
  ;; (setq obj1 (make-prism (append p (if close? (list (copy-seq (car p))))) 10))
  (setq obj2 (make-cube 1 1 100))
  (objects (list p1 p2 p3 p4 p5 p6 obj2))
  (let* ((cnt 0) col)
    (do-until-key
     (send obj2 :newcoords (make-coords :pos (float-vector  (* 20 (sin (* 0.05 (incf cnt)))) (* 20 (cos (* 0.05 cnt))) 0)))
     (send *viewer* :draw-objects)
     (x::window-main-one)
     (setq col1 (print (pqp-collision-check p1 obj2)))
     (setq col2 (pqp-collision-check p2 obj2))
     (setq col3 (pqp-collision-check p3 obj2))
     (setq col4 (pqp-collision-check p4 obj2))
     (setq col5 (pqp-collision-check p5 obj2))
     (setq col6 (pqp-collision-check p6 obj2))
     (if (eq col1 1) (send p1 :set-color :moccasin)
       (send p1 :set-color :saddlebrown))
     (if (eq col2 1) (send p2 :set-color :moccasin)
       (send p2 :set-color :saddlebrown))
     (if (eq col3 1) (send p3 :set-color :moccasin)
       (send p3 :set-color :saddlebrown))
     (if (eq col4 1) (send p4 :set-color :moccasin)
       (send p4 :set-color :saddlebrown))
     (if (eq col5 1) (send p5 :set-color :moccasin)
       (send p5 :set-color :saddlebrown))
     (if (eq col6 1) (send p6 :set-color :moccasin)
       (send p6 :set-color :saddlebrown))
     (unix::usleep (* 10 1000)))))
