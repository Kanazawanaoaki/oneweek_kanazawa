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
(send *peeler* :locate #f(450 -250 830))

;; set まな板
(load "../model/cutting-board.l")
(setq *cutting-board* (cutting-board))
(send *cutting-board* :locate #f(550 0 825))

;; set arrow
(load "models/arrow-object.l")
(setq *arrow* (arrow))

(make-potato)
(send *potato* :translate #f(500 0 850))
(objects (list *robot* p1 p2 p3 p4 *peeler* *cutting-board*))

(send *arrow* :newcoords (send *potato* :copy-worldcoords))
(send *arrow* :rotate (deg2rad 90) :y)

(send *robot* :reset-manip-pose)

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

;; def moves 
(defun set-peel ()
  (send *arrow* :newcoords (make-coords :pos #f(500 50 1050) :rpy #f(-1.57 0 0)))
  
  (send *arrow* :rotate (deg2rad -30) :z)
  (send *arrow* :rotate (deg2rad -50) :y)

  (send *robot* :larm :inverse-kinematics
	*arrow*
	:rotation-axis t
	:debug-view t)
  )

(defun peel-move ()
  (send *arrow* :newcoords (send (send *robot* :larm :end-coords) :copy-worldcoords))
  (send *arrow* :rotate (deg2rad 180) :z)
  (send *arrow* :rotate (deg2rad -90) :y)
  (send *arrow* :rotate (deg2rad 180) :x)
  
  (send *arrow* :translate #f(50 0 -20))  ;; ここを認識から大きさに合わせてとかやるのが良い。

  (send *robot* :rarm :inverse-kinematics
	*arrow*
	:move-target (car (send *peeler* :attention))
	:rotation-axis t
	:debug-view t)

  (unix:sleep 1)

  (send *arrow* :translate #f(-100 0 0))
  
  (send *robot* :rarm :inverse-kinematics
	*arrow*
	:move-target (car (send *peeler* :attention))
	:rotation-axis t
	:debug-view t)
  )


(defun put-potato ()
  (send *arrow* :newcoords (make-coords :pos #f(500 0 850)))
  (send *arrow* :rotate (deg2rad 90) :y)
  (send *arrow* :rotate (deg2rad -45) :x :world)
  (send *arrow* :rotate (deg2rad -90) :z :world)  

  (send *robot* :larm :inverse-kinematics *arrow* :debug-view t)
  (send (send *robot* :larm :end-coords) :dissoc *potato*)
  (unix:usleep 100000)

  (send *robot* :reset-manip-pose)
  (unix:usleep 100000)
  )


(defun pick-up-potato ()
  (send *arrow* :newcoords (make-coords :pos #f(500 0 850)))
  (send *arrow* :rotate (deg2rad 90) :y)
  (send *arrow* :rotate (deg2rad 45) :x :world)
  (send *arrow* :rotate (deg2rad -90) :z :world)
  
  (send *robot* :larm :inverse-kinematics *arrow* :debug-view t)
  (send (send *robot* :larm :end-coords) :assoc *potato*)
  (unix:usleep 100000)
  )


;; def procedure
(defun set-peel-1 ()
  (set-peel)
  (format t ";; please run (peel-move-1)~%"))  

(defun peel-move-1 ()
  (peel-move)
  
  (send p4 :set-color :moccasin)
  (send *viewer* :draw-objects)

  (unix:usleep 100000)  

  (format t ";; please run (put-potato-1)~%")
  )

(defun put-potato-1 ()
  (put-potato)

  (format t ";; please run (pick-potato-2)~%")
  )

(defun pick-potato-2 ()
  (pick-up-potato)
  (set-peel)

  (format t ";; please run (peel-move-2)~%")
  )

(defun peel-move-2 ()
  (peel-move)
  
  (send p3 :set-color :moccasin)
  (send *viewer* :draw-objects)

  (unix:usleep 100000)

  (format t ";; please run (put-potato-2)~%")
  )

(defun put-potato-2 ()
  (put-potato)

  (format t ";; please run (pick-potato-3)~%")
  )

(defun pick-potato-3 ()
  (pick-up-potato)
  (set-peel)

  (format t ";; please run (peel-move-3)~%"))

(defun peel-move-3 ()
  (peel-move)
  (send p1 :set-color :moccasin)
  (send *viewer* :draw-objects)

  (unix:usleep 100000)
  
  (format t ";; please run (put-potato-3)~%")
  )

(defun put-potato-3 ()
  (put-potato)

  (format t ";; please run (pick-potato-4)~%")
  )

(defun pick-potato-4 ()
  (pick-up-potato)
  (set-peel)

  (format t ";; please run (peel-move-4)~%"))

(defun peel-move-4 ()
  (peel-move)
  (send p2 :set-color :moccasin)
  (send *viewer* :draw-objects)
  )

(set-peel-1)
(format t ";; you can also run (now-devel) or (exec-all)~%"))

(defun now-devel ()
  (peel-move-1)
  (put-potato-1)
  (pick-potato-2)
  (peel-move-2)
  )

(defun exec-all ()
  (peel-move-1)
  (put-potato-1)
  (pick-potato-2)
  (peel-move-2)
  (put-potato-2)
  (pick-potato-3)
  (peel-move-3)
  (put-potato-3)
  (pick-potato-4)
  (peel-move-4)
  )
