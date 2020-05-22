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
  );; robot initialize
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
  (send b3 :translate #f(-250 0 0))
  (setq b4 (make-cube 500 500 500))
  (send b4 :translate #f(250 0 0))

  (send b2 :translate #f(1 0 0))

  (setq b5 (make-cube 500 500 500))
  (send b5 :translate #f(0 -240 0))

  (setq b6 (make-cube 500 500 500))
  (send b6 :translate #f(0 -260 0))

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

  )

;; set knife
(load "../model/my-knife.l")
(setq *knife* (knife))
(send *knife* :locate #f(500 -400 830))

;; set まな板
(load "../model/cutting-board.l")
(setq *cutting-board* (cutting-board))
(send *cutting-board* :locate #f(620 -160 825))

;; set arrow
(load "models/arrow-object.l")
(setq *arrow* (arrow))

(make-potato)
(send *potato* :translate #f(620 -160 850))
(send *potato* :rotate (deg2rad -90) :z :world)
(objects (list *robot* p1 p2 p3 p4 p5 p6 *knife* *cutting-board*))

(send *arrow* :newcoords (send *potato* :copy-worldcoords))
(send *arrow* :rotate (deg2rad 90) :y)
(send *arrow* :translate #f(0 20 0) :world)
(send *arrow* :rotate (deg2rad -45) :x :world)

(send *robot* :reset-manip-pose)
(send *robot* :torso_lift_joint :joint-angle 325)

(send *robot* :larm :inverse-kinematics
      *arrow*
      :rotation-axis t
      :debug-view t)
(send (send *robot* :larm :end-coords) :assoc *potato*)

(send *robot* :rarm :inverse-kinematics
      (car (send *knife* :handle))
      :rotation-axis t
      :debug-view t)
(send (send *robot* :rarm :end-coords) :assoc *knife*)


(defun cut-set ()
  (send *arrow* :newcoords (make-coords :pos (send *potato* :worldpos)))
  (send *arrow* :translate #f(0 0 40))

  (send *robot* :rarm :inverse-kinematics
	*arrow*
	:move-target (car (send *knife* :attention))
	:rotation-axis t
	:debug-view t)
  )

(defun cut-move ()
  (send *arrow* :translate #f(0 0 -60)) ;; 本当は切れるまでとかまな板につくまで下に押して行く

  (send *robot* :rarm :inverse-kinematics
	*arrow*
	:move-target (car (send *knife* :attention))
	:rotation-axis t
	:debug-view t)
  )


(defun cut-potato-1 ()
  (cut-move)

  (send *potato* :dissoc p1)
  (send *potato* :dissoc p2)
  (send *potato* :dissoc p3)

  (setq *potato2* (make-cascoords))
  (send *potato2* :newcoords (send *potato* :copy-worldcoords))

  (send *potato2* :assoc p1)
  (send *potato2* :assoc p2)
  (send *potato2* :assoc p3)

  (send *potato2* :translate #f(0 -30 0) :world)
  (send *viewer* :draw-objects)
  )

  
(cut-set)
