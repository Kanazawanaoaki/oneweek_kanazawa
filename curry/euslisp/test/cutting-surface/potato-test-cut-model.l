;; robot initialize
(load "package://pr2eus/pr2.l")   
(setq *robot* (pr2))

;; set knife
(load "../../model/my-knife.l")
(setq *knife* (knife))
(send *knife* :locate #f(500 -400 830))

;; set まな板
(load "../../model/cutting-board.l")
(setq *cutting-board* (cutting-board))
(send *cutting-board* :locate #f(620 -160 825))

;; set arrow
(load "models/arrow-object.l")
(setq *arrow* (arrow))

;; set potato
(load "../../model/potato-test-model.l")
(setq *potato* (potato))
(send *potato* :cut)
(send *potato* :translate #f(620 -160 850))
(send *potato* :rotate (deg2rad -90) :z :world)
(objects (list *robot* p1 p2 p3 p4 p5 p6 *knife* *cutting-board*))

(send *arrow* :newcoords (send *potato* :copy-worldcoords))
(send *arrow* :rotate (deg2rad 90) :y)
(send *arrow* :translate #f(0 20 0) :world)
(send *arrow* :rotate (deg2rad -45) :x :world)

(send *robot* :reset-manip-pose)
(send *robot* :torso_lift_joint :joint-angle 325)

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

(defun set-move-1 ()
  (send *robot* :larm :inverse-kinematics
	*arrow*
	:rotation-axis t
	:debug-view t)
  (send (send *robot* :larm :end-coords) :assoc *potato*)

  (cut-set-move *cut-point-1*)
  (unix:usleep 100000)

  (format t ";; please run (cut-potato-1)~%")
  )
  

(defun cut-potato-1 ()
  ;; (cut-move)
  (cut-move *cut-point-1*)
  
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
  (unix:usleep 100000)

  (format t ";; please run (set-move-2)~%")
  )

(defun set-move-2 ()
  (send *arrow* :newcoords (make-coords :pos #f(520 -300 1030)))
  (send *robot* :rarm :inverse-kinematics *arrow* :rotation-axis nil :debug-view t)
  (unix:usleep 100000)

  (send *arrow* :newcoords (make-coords :pos #f(660.0 -60.0 830.0) :rpy #f( 0.785 1.571 -0.785)))
  (send *robot* :larm :inverse-kinematics
	*arrow*
	:move-target *potato*
	:rotation-axis t
	:debug-view t)
  (send *robot* :larm :end-coords :dissoc *potato*)
  (unix:usleep 100000)

  (send *arrow* :newcoords (send *potato2* :copy-worldcoords))
  (send *arrow* :translate #f(20 0 30))
  (send *arrow* :rotate (deg2rad 90) :y)

  (send *robot* :larm :inverse-kinematics *arrow* :debug-view t)
  (send *robot* :larm :end-coords :assoc *potato2*)
  (unix:usleep 100000)

  (send *arrow* :newcoords (make-coords :pos #f(610.0 -200.0 830.0) :rpy #f( 0.785 -1.571 -2.357)))
  (send *robot* :larm  :inverse-kinematics
	*arrow*
	:move-target *potato2*
	:rotation-axis t
	:debug-view t)
  (unix:usleep 100000)

  (cut-set-move *cut-point-2*)
  (unix:usleep 100000)
  
  (format t ";; please run (cut-potato-2)~%")
  )

(defun cut-potato-2 ()
  (cut-move *cut-point-2*)
  
  (send *potato2* :dissoc p3)

  (send p3 :translate #f(0 -30 0) :world)
  (send *viewer* :draw-objects)
  (unix:usleep 100000)

  (format t ";; please run (set-move-3)~%")
  )

(defun set-move-3 ()
  (cut-set-move *cut-point-3*)
  (unix:usleep 100000)
  
  (format t ";; please run (cut-potato-3)~%")
  )

(defun cut-potato-3 ()
  (cut-move *cut-point-3*)

  (send *potato2* :dissoc p2)

  (send p2 :translate #f(0 -20 0) :world)
  (send *viewer* :draw-objects)
  (unix:usleep 100000)
  
  (format t ";; please run (set-move-4)~%")
  )

(defun set-move-4 ()
  (send *arrow* :newcoords (make-coords :pos #f(520 -300 1030)))
  (send *robot* :rarm :inverse-kinematics *arrow* :rotation-axis nil :debug-view t)
  (unix:usleep 100000)

  (send *robot* :larm :inverse-kinematics
	(send (send p1 :copy-worldcoords) :translate #f(0 -10 0) :world)
	:move-target p1
	:debug-view t)
  (send *robot* :larm :end-coords :dissoc *potato2*)
  (unix:usleep 100000)

  (send *arrow* :newcoords (send *potato* :copy-worldcoords))
  (send *arrow* :rotate (deg2rad 180) :x)
  (send *arrow* :translate #f(-10 0 -20))
  (send *arrow* :rotate (deg2rad -30) :y)

  (send *robot* :larm :inverse-kinematics
	*arrow*
	:rotation-axis t
	:debug-view t)
  (send *robot* :larm :end-coords :assoc *potato*)
  (unix:usleep 100000)

  (send *arrow* :newcoords (make-coords :pos #f(610 -110 830)  :rpy #f(0.785 1.571 -0.785)))
  (send *robot* :larm :inverse-kinematics
	*arrow*
	:move-target *potato*
	:rotation-axis t
	:debug-view t)
  (unix:usleep 100000)

  (cut-set-move *cut-point-4*)
  (unix:usleep 100000)
  
  (format t ";; please run (cut-potato-4)~%")  
  )

(defun cut-potato-4 ()
  (cut-move *cut-point-4*)
  
  (send *potato* :dissoc p6)

  (send p6 :translate #f(0 -30 0) :world)
  (send *viewer* :draw-objects)
  (unix:usleep 100000)

  (format t ";; please run (set-move-5)~%")
  )

(defun set-move-5 ()
  (cut-set-move *cut-point-5*)
  (unix:usleep 100000)
  
  (format t ";; please run (cut-potato-5)~%")
  )

(defun cut-potato-5 ()
  (cut-move *cut-point-5*)
  
  (send *potato* :dissoc p5)

  (send p5 :translate #f(0 -20 0) :world)
  (send *viewer* :draw-objects)
  (unix:usleep 100000)

  ;; (format t ";; please run (set-move-5)~%")
  )


(format t ";; please run (set-move-1)~%")
(format t ";; you can also run (now-devel) or (exec-all)~%")

(defun now-devel ()
  (set-move-1)
  (cut-potato-1)
  (set-move-2)
  (cut-potato-2)
  (set-move-3)
  (cut-potato-3)
  )

(defun exec-all ()
  (set-move-1)
  (cut-potato-1)
  (set-move-2)
  (cut-potato-2)
  (set-move-3)
  (cut-potato-3)
  (set-move-4)
  (cut-potato-4)
  (set-move-5)
  (cut-potato-5)
  )
  
