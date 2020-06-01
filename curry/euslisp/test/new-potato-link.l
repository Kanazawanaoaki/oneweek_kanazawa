(defun x-mul (point num)
  (float-vector (* (elt point 0) num) (elt point 1) (elt point 2)))

(defun make-potato-link ()
  (setq b1 (make-sphere 30))
  (setq v-list (list (x-mul (car (send b1 :vertices)) 1.5)))
  (dolist (x (cdr (send b1 :vertices))) (setq v-list (append v-list (list (x-mul x 1.5)))))
  (setq b2 (convex-hull-3d v-list))

  (send b2 :set-color :saddlebrown)

  (setq *potato* (instance bodyset-link :init (make-cascoords) :bodies (list b2) :weight 1 :centroid (float-vector 0.0 0.0 0.0) :inertia-tensor #2f((1.0 0.0 0.0) (0.0 1.0 0.0) (0.0 0.0 1.0))))
  )

(defun make-potato-peel-link ()
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

  (send p1 :assoc p2)
  (send p1 :assoc p3)
  (send p1 :assoc p4)

  (setq *potato-p* (instance bodyset-link :init (make-cascoords) :bodies (list p1 p2 p3 p4) :weight 1 :centroid (float-vector 0.0 0.0 0.0) :inertia-tensor #2f((1.0 0.0 0.0) (0.0 1.0 0.0) (0.0 0.0 1.0))))
  )


(defun make-potato-cut-link ()
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

  (send p4 :assoc p1)
  (send p4 :assoc p2)
  (send p4 :assoc p3)
  (send p4 :assoc p5)
  (send p4 :assoc p6)

  (setq *cut-point-1* (make-cascoords :pos #f(0 0 -20)))
  (send *cut-point-1* :rotate (deg2rad 90) :z)
  (send p1 :assoc *cut-point-1*)

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

  (setq *potato-c* (instance bodyset-link :init (make-cascoords) :bodies (list p4 p1 p2 p3 p5 p6) :weight 1 :centroid (float-vector 0.0 0.0 0.0) :inertia-tensor #2f((1.0 0.0 0.0) (0.0 1.0 0.0) (0.0 0.0 1.0))))
  )


(make-potato-link)

(send *potato* :translate #f(0 0 50))

;; set arrow
(load "models/arrow-object.l")
(setq *arrow* (arrow))

(objects (list *potato*))

(send *viewer* :draw-objects)

(format t ";; please run (p1-1)~%")

(defun p1-1 ()
  (make-potato-peel-link)
  (send *potato-p* :newcoords (send *potato* :copy-worldcoords))
  (send *potato-p* :rotate (deg2rad 45) :x)
  (objects (list *potato-p*))
  
  (send p1 :set-color :moccasin)

  (send *viewer* :draw-objects)
  (format t ";; please run (p1-2)~%")
  )

(defun p1-2 ()
  (send *potato-p* :rotate (deg2rad -90) :x)

  (send *viewer* :draw-objects)
  (format t ";; please run (p2-1)~%")
  )
  
(defun p2-1 ()
  (send p2 :set-color :moccasin)

  (send *viewer* :draw-objects)
  (format t ";; please run (p2-2)~%")
  )

(defun p2-2 ()
  (send *potato-p* :rotate (deg2rad -90) :x)

  (send *viewer* :draw-objects)
  (format t ";; please run (p3-1)~%")
  )

(defun p3-1 ()
  (send p4 :set-color :moccasin)

  (send *viewer* :draw-objects)
  (format t ";; please run (p3-2)~%")
  )

(defun p3-2 ()
  (send *potato-p* :rotate (deg2rad -90) :x)

  (send *viewer* :draw-objects)
  (format t ";; please run (p4-1)~%")
  )

(defun p4-1 ()
  (send p3 :set-color :moccasin)

  (send *viewer* :draw-objects)
  (format t ";; please run (c1-1)~%")
  )

(defun c1-1 ()
  (make-potato-cut-link)
  (send *potato-c* :newcoords (make-coords :pos (send *potato-p* :worldpos)))
  
  ;; (send *potato-c* :newcoords (send *potato* :copy-worldcoords))
  ;; (send *potato-c* :rotate (deg2rad -45) :x)

  (objects (list *potato-c* *arrow*))

  (send *arrow* :newcoords (send *cut-point-1* :copy-worldcoords))
  (send *viewer* :draw-objects)
  
  (format t ";; please run (c1-2)~%")
  )

(defun c1-2 ()
  (send p4 :dissoc p1)
  (send p4 :dissoc p2)
  (send p4 :dissoc p3)

  (send p1 :assoc p2)
  (send p1 :assoc p3)

  (setq *potato2* (instance bodyset-link :init (make-cascoords) :bodies (list p1 p2 p3) :weight 1 :centroid (float-vector 0.0 0.0 0.0) :inertia-tensor #2f((1.0 0.0 0.0) (0.0 1.0 0.0) (0.0 0.0 1.0))))

  (send *potato2* :translate #f(30 0 0) :world)
  (send *viewer* :draw-objects)
  (unix:usleep 100000)

  (format t ";; please run (c2-1)~%")  
  )

(defun c2-1 ()
  (send *arrow* :newcoords (send *cut-point-2* :copy-worldcoords))

  (send *viewer* :draw-objects)
  (format t ";; please run (c2-2)~%")
  )
  
(defun c2-2 ()
  (send p1 :dissoc p3)
  (send p3 :translate #f(0 0 -20))
  (send *viewer* :draw-objects)
  )

(defun c3-1 ()
  (send *arrow* :newcoords (send *cut-point-3* :copy-worldcoords))

  (send *viewer* :draw-objects)
  (format t ";; please run (c3-2)~%")
  )
  
(defun c3-2 ()
  (send p1 :dissoc p2)
  (send p2 :translate #f(0 0 -10))
  (send *viewer* :draw-objects)
  )

(defun c4-1 ()
  (send *arrow* :newcoords (send *cut-point-4* :copy-worldcoords))

  (send *viewer* :draw-objects)
  (format t ";; please run (c4-2)~%")
  )
  
(defun c4-2 ()
  (send p4 :dissoc p6)
  (send p6 :translate #f(0 0 -20))
  (send *viewer* :draw-objects)

  (format t ";; please run (c5-1)~%")
  )

(defun c5-1 ()
  (send *arrow* :newcoords (send *cut-point-5* :copy-worldcoords))

  (send *viewer* :draw-objects)
  (format t ";; please run (c5-2)~%")
  )

(defun c5-2 ()
  (send p4 :dissoc p5)
  (send p5 :translate #f(0 0 -10))
  (send *viewer* :draw-objects)
  )  
  

(format t ";; please run (p1-1)~%")
(format t ";; you can also run (now-devel) or (exec-all)~%"))


(defun now-devel ()
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
  )
