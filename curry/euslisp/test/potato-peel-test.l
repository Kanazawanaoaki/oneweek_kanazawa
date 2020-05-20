;; robot initialize
(load "package://pr2eus/pr2.l")   
(setq *robot* (pr2)) 


(defun x-mul (point num)
  (float-vector (* (elt point 0) num) (elt point 1) (elt point 2)))

(defun make-potato ()
  
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

  (send p1 :rotate (deg2rad 45) :x)

  (setq *potato* (make-cascoords))
  (send *potato* :assoc p1)
  )

;; set peeler
(load "../model/peeler.l")
(setq *peeler* (peeler))
(send *peeler* :locate #f(500 -200 600))

;; set arrow
(load "models/arrow-object.l")
(setq *arrow* (arrow))

(make-potato)
(send *potato* :translate #f(500 100 600))
(objects (list *robot* p1 p2 p3 p4 *peeler*))

(send *arrow* :newcoords (send *potato* :copy-worldcoords))
(send *arrow* :rotate (deg2rad 90) :y)

(send *robot* :larm :inverse-kinematics
      *arrow*
      :rotation-axis t
      :debug-view t)
(send (send *robot* :larm :end-coords) :assoc *potato*)

(send *robot* :rarm :inverse-kinematics
      (car (send *peeler* :handle))
      :rotation-axis t
      :debug-view t)
(send (send *robot* :rarm :end-coords) :assoc *peeler*)


