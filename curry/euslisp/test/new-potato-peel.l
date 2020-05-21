(defun x-mul (point num)
  (float-vector (* (elt point 0) num) (elt point 1) (elt point 2)))

(setq b1 (make-sphere 30))
(setq v-list (list (x-mul (car (send b1 :vertices)) 1.5)))
(dolist (x (cdr (send b1 :vertices))) (setq v-list (append v-list (list (x-mul x 1.5)))))
(setq b2 (convex-hull-3d v-list))
     
(setq b3 (make-cube 500 500 500))
(send b3 :translate #f(0 -250 0))

(setq b4 (make-cube 500 500 500))
(send b4 :translate #f(0 0 -250))

(setq b5 (make-cube 500 500 500))
(send b5 :translate #f(0 250 0))

(setq b6 (make-cube 500 500 500))
(send b6 :translate #f(0 0 250))


(send b2 :translate #f(0 0 1))
(setq b7 (body- b2 b4))
(setq b8 (body- b2 b6))

(send b7 :translate #f(0 1 0))
(setq p1 (body- b7 b3))
(setq p2 (body- b7 b5))

(send b8 :translate #f(0 1 0))
(setq p3 (body- b8 b3))
(setq p4 (body- b8 b5))

(send p1 :set-color :saddlebrown)
(send p2 :set-color :saddlebrown)
(send p3 :set-color :saddlebrown)
(send p4 :set-color :saddlebrown)

(objects (list p1 p2 p3 p4))

(defun test-pqp-loop (&optional (close? t)
                                (p (list #f(15 0 0) #f(15 120 0) #f(-15 120 0) #f(-15 0 0) #f(-120 0 0) #f(-120 -30 0) #f(120 -30 0) #f(120 0 0))))
  ;; (setq obj1 (make-prism (append p (if close? (list (copy-seq (car p))))) 10))
  (setq obj2 (make-cube 100 1 1))
  (objects (list p1 p2 p3 p4 obj2))
  (let* ((cnt 0) col)
    (do-until-key
     (send obj2 :newcoords (make-coords :pos (float-vector 0 (* 20 (sin (* 0.05 (incf cnt)))) (* 20 (cos (* 0.05 cnt))) )))
     (send *viewer* :draw-objects)
     (x::window-main-one)
     (setq col1 (print (pqp-collision-check p1 obj2)))
     (setq col2 (pqp-collision-check p2 obj2))
     (setq col3 (pqp-collision-check p3 obj2))
     (setq col4 (pqp-collision-check p4 obj2))
     (if (eq col1 1) (send p1 :set-color :moccasin)
       (send p1 :set-color :saddlebrown))
     (if (eq col2 1) (send p2 :set-color :moccasin)
       (send p2 :set-color :saddlebrown))
     (if (eq col3 1) (send p3 :set-color :moccasin)
       (send p3 :set-color :saddlebrown))
     (if (eq col4 1) (send p4 :set-color :moccasin)
       (send p4 :set-color :saddlebrown))
     (unix::usleep (* 10 1000)))))
