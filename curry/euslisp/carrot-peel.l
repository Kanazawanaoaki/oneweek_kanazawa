;; robot initialize
(load "package://pr2eus/pr2.l")   
(setq *robot* (pr2)) 

(defun make-carrot ()
  ;; (setq b1 (make-cylinder 30 2))
  ;; (send b1 :translate #f(100 0 0))
  ;; (send b1 :rotate (deg2rad -90) :y)
  ;; (send b1 :worldcoords)
  ;; (setq v-list (list (car (send b1 :vertices))))
  ;; (dolist (x (cdr (send b1 :vertices))) (if (> (elt x 0) 99) (setq v-list (append v-list (list x)))))

  (setq v-list (list #f(100.0 -15.0 25.9808) #f(100.0 -25.9808 15.0) #f(100.0 -30.0 -4.085621e-14) #f(100.0 -25.9808 -15.0) #f(100.0 -15.0 -25.9808) #f(100.0 2.842171e-14 -30.0) #f(100.0 15.0 -25.9808) #f(100.0 25.9808 -15.0) #f(100.0 30.0 1.598721e-14) #f(100.0 25.9808 15.0) #f(100.0 15.0 25.9808) #f(100.0 0.0 30.0)))

  (setq b2 (make-cone #f(-100 0 0) v-list))

  (setq b3 (make-sphere 30))
  (send b3 :locate #f(100 0 0))

  (setq b4 (make-cube 100 100 100))
  (send b4 :translate #f(49 0 0))
  ;; (setq b3 (body- b3 b4))
  (setq p1 (body- b3 b4))

  (setq b5 (make-cube 200 200 200))
  (send b5 :translate #f(-70 0 0))
  (setq p2 (body- b2 b5))

  (setq t1 (body- b2 p2))
  (send b5 :translate #f(-90 0 0))
  (setq p3 (body- t1 b5))

  (setq p4 (body- t1 p3))

  (send p1 :set-color :orangered)
  (send p2 :set-color :orangered)
  (send p3 :set-color :orangered)
  (send p4 :set-color :orangered)

  (setq *cut-point-1* (make-cascoords :pos #f(100 0 0)))
  (send *cut-point-1* :rotate (deg2rad 90) :z)

  (setq *cut-point-2* (make-cascoords :pos #f(30 0 0)))
  (send *cut-point-2* :rotate (deg2rad 90) :z)

  (setq *cut-point-3* (make-cascoords :pos #f(-60 0 0)))
  (send *cut-point-3* :rotate (deg2rad 90) :z)
  (send *cut-point-3* :rotate (deg2rad 180) :z :world)

  (send p2 :assoc *cut-point-1*)
  (send p2 :assoc *cut-point-2*)
  (send p3 :assoc *cut-point-3*)

  (send p2 :assoc p1)
  (send p2 :assoc p3)
  (send p3 :assoc p4)

  (setq *carrot* (make-cascoords))
  (send *carrot* :assoc p2)
  )

;; set knife
(load "model/my-knife.l")
(setq *knife* (knife))
(send *knife* :locate #f(500 -400 830))

;; set peeler
(load "model/peeler.l")
(setq *peeler* (peeler))
(send *peeler* :locate #f(540 -310 830))

;; set まな板
(load "model/cutting-board.l")
(setq *cutting-board* (cutting-board))
(send *cutting-board* :locate #f(550 -100 825))

;; set arrow
(load "models/arrow-object.l")
(setq *arrow* (arrow))

(make-carrot)
(send *carrot* :translate #f(530 -90 850))
(send *carrot* :rotate (deg2rad -90) :z)
(objects (list *robot* p1 p2 p3 p4 *peeler* *cutting-board* *knife*))

(send *robot* :rotate (deg2rad -45) :z)
(send *robot* :reset-manip-pose)
(send *robot* :torso_lift_joint :joint-angle 325)


(send *arrow* :newcoords (send *carrot* :copy-worldcoords))
(send *arrow* :rotate (deg2rad 90) :y)
;; (send *arrow* :translate #f(0 10 0) :world)
(send *arrow* :rotate (deg2rad -45) :x :world)


(send *robot* :rarm :inverse-kinematics
      (car (send *knife* :handle))
      :rotation-axis t
      :debug-view t)
(send (send *robot* :rarm :end-coords) :assoc *knife*)


(defun cut-set-move (*target*)
  (send *arrow* :newcoords (send *target* :copy-worldcoords))
  (send *arrow* :translate #f(0 0 50))

  (send *robot* :rarm :inverse-kinematics
	*arrow*
	:move-target (car (send *knife* :attention))
	:rotation-axis t
	:debug-view t)
  )

(defun cut-move (*target*)
  (send *arrow* :newcoords (send *target* :copy-worldcoords))
  ;; (send *arrow* :translate #f(0 0 -60)) ;; 本当は切れるまでとかまな板につくまで下に押して行く

  (send *robot* :rarm :inverse-kinematics
	*arrow*
	:move-target (car (send *knife* :attention))
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

  (unix:usleep 100000)

  (send *arrow* :translate #f(-100 0 0))
  
  (send *robot* :rarm :inverse-kinematics
	*arrow*
	:move-target (car (send *peeler* :attention))
	:rotation-axis t
	:debug-view t)
  )

(defun put-carrot ()
  (send *arrow* :newcoords (make-coords :pos #f(500 -150 850)))
  (send *arrow* :rotate (deg2rad 90) :y)
  (send *arrow* :rotate (deg2rad -45) :x :world)
  (send *arrow* :rotate (deg2rad -90) :z :world)  

  (send *robot* :larm :inverse-kinematics *arrow* :debug-view t)
  (send (send *robot* :larm :end-coords) :dissoc p2)
  (unix:usleep 100000)

  (send *robot* :reset-manip-pose)
  (unix:usleep 100000)
  )


(defun pick-up-carrot ()
  (send *arrow* :newcoords (make-coords :pos #f(500 -150 850)))
  (send *arrow* :rotate (deg2rad 90) :y)
  (send *arrow* :rotate (deg2rad 45) :x :world)
  (send *arrow* :rotate (deg2rad -90) :z :world)
  
  (send *robot* :larm :inverse-kinematics *arrow* :debug-view t)
  (send (send *robot* :larm :end-coords) :assoc p2)
  (unix:usleep 100000)
  )

(defun set-peel ()
  (send *arrow* :newcoords (send *robot* :copy-worldcoords))
  (send *arrow* :translate #f(550 150 1050))
  (send *arrow* :rotate (deg2rad -120) :z)
  (send *arrow* :rotate (deg2rad -40) :y)
  
  (send *robot* :larm :inverse-kinematics
  	*arrow*
  	:rotation-axis t
  	:debug-view t)
  )


(defun set-move-1 ()
  (send *robot* :larm :inverse-kinematics
	*arrow*
	:rotation-axis t
	:debug-view t)
  (send (send *robot* :larm :end-coords) :assoc *carrot*)

  (cut-set-move *cut-point-1*)
  (unix:usleep 100000)

  (format t ";; please run (cut-carrot-1)~%")
  )

(defun cut-carrot-1 ()
  (cut-move *cut-point-1*)

  (send p2 :dissoc p1)

  (send p1 :translate #f(0 -40 0) :world)
  (send *viewer* :draw-objects)
  (unix:usleep 100000)

  (format t ";; please run (set-move-2)~%")
  )


(defun set-move-2 ()
  (send *arrow* :newcoords (make-coords :pos #f(520 -300 1030)))
  (send *robot* :rarm :inverse-kinematics *arrow* :rotation-axis nil :debug-view t)
  (unix:usleep 100000)
  
  (send *arrow* :newcoords (send *carrot* :copy-worldcoords))
  (send *arrow* :translate #f(0 -20 0) :world)

  (send *robot* :larm :inverse-kinematics
	*arrow*
	:move-target *carrot*
	:rotation-axis t
	:debug-view t)
  (unix:usleep 100000)

  (cut-set-move *cut-point-2*)
  (unix:usleep 100000)
  
  (format t ";; please run (cut-carrot-2)~%")
  )
  
(defun cut-carrot-2 ()
  (cut-move *cut-point-2*)

  (send p2 :dissoc p3)

  (send p2 :translate #f(0 -10 0) :world)
  (send *viewer* :draw-objects)
  (unix:usleep 100000)

  (format t ";; please run (set-move-3)~%")
  )

(defun set-move-3 ()
  (send *arrow* :newcoords (make-coords :pos #f(520 -300 1030)))
  (send *robot* :rarm :inverse-kinematics *arrow* :rotation-axis nil :debug-view t)
  (unix:usleep 100000)

  (send *arrow* :newcoords (make-coords :pos  #f(500 -400 830)))
  (send *robot* :rarm :inverse-kinematics
	*arrow*
	:move-target *knife*
	:rotation-axis t
	:debug-view t)
  (unix:usleep 100000)
  
  (send *robot* :rarm :end-coords :dissoc *knife*)

  (send *robot* :larm :end-coords :dissoc *carrot*)
  (send *robot* :larm :end-coords :assoc p3)

  (send *arrow* :newcoords (send p3 :copy-worldcoords))
  (send *arrow* :translate #f(0 80 0) :world)

  (send *robot* :larm :inverse-kinematics
	*arrow*
	:move-target p3
	:rotation-axis t
	:debug-view t)
  (unix:usleep 100000)


  (send *robot* :larm :end-coords :dissoc p3)

  (send *arrow* :newcoords (send p2 :copy-worldcoords))
  (send *arrow* :translate #f(60 0 0))
  (send *arrow* :rotate (deg2rad 90) :y)
  (send *robot* :larm :inverse-kinematics
	*arrow*
	:rotation-axis t
	:debug-view t)
  (unix:usleep 100000)

  (send *robot* :larm :end-coords :assoc p2)

  (set-peel)
  (unix:usleep 100000)

  ;; grasp peeler
  (send *robot* :rarm :inverse-kinematics
	(car (send *peeler* :handle))
	:rotation-axis t
	:debug-view t)
  (send (send *robot* :rarm :end-coords) :assoc *peeler*)

  (format t ";; please run (peel-carrot-1)~%")
  )

(defun peel-carrot-1 ()
  (peel-move)
  
  (unix:usleep 100000)

  (format t ";; please run (put-carrot-1)~%")
  )

(defun put-carrot-1 ()
  (put-carrot)

  (format t ";; please run (pick-carrot-2)~%")
  )

(defun pick-carrot-2 ()
  (pick-up-carrot)
  (set-peel)

  (format t ";; please run (peel-carrot-2)~%")
  )

(defun peel-carrot-2 ()
  (peel-move)
  
  (unix:usleep 100000)

  (format t ";; please run (put-carrot-2)~%")
  )

(defun put-carrot-2 ()
  (put-carrot)

  (format t ";; please run (pick-carrot-3)~%")
  )

(defun pick-carrot-3 ()
  (pick-up-carrot)
  (set-peel)

  (format t ";; please run (peel-carrot-3)~%")
  )

(defun peel-carrot-3 ()
  (peel-move)
  
  (unix:usleep 100000)

  (format t ";; please run (put-carrot-3)~%")
  )

(defun put-carrot-3 ()
  (put-carrot)

  (format t ";; please run (pick-carrot-4)~%")
  )

(defun pick-carrot-4 ()
  (pick-up-carrot)
  (set-peel)

  (format t ";; please run (peel-carrot-4)~%")
  )

(defun peel-carrot-4 ()
  (peel-move)
  
  (unix:usleep 100000)

  ;; (format t ";; please run (put-carrot-4)~%")
  )


(format t ";; please run (set-move-1)~%")
(format t ";; you can also run (now-devel) or (exec-all)~%")

(defun now-devel ()
  (set-move-1)
  (cut-carrot-1)
  (set-move-2)
  (cut-carrot-2)
  (set-move-3)
  )

(defun exec-all ()
  (set-move-1)
  (cut-carrot-1)
  (set-move-2)
  (cut-carrot-2)
  (set-move-3)
  (peel-carrot-1)
  (put-carrot-1)
  (pick-carrot-2)
  (peel-carrot-2)
  (put-carrot-2)
  (pick-carrot-3)
  (peel-carrot-3)
  (put-carrot-3)
  (pick-carrot-4)
  (peel-carrot-4)
  )
