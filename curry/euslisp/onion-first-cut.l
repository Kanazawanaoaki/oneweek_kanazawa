;; robot initialize
(load "package://pr2eus/pr2.l")   
(setq *robot* (pr2)) 

(defun z-mul (point num)
  (float-vector (elt point 0) (elt point 1) (* (elt point 2) num)))

(defun make-onion ()
  (setq b1 (make-sphere 45))
  (setq v-list (list (z-mul (car (send b1 :vertices)) 0.78)))
  (dolist (x (cdr (send b1 :vertices))) (setq v-list (append v-list (list (z-mul x 0.78)))))
  (setq b2 (convex-hull-3d v-list))

  (setq b1 (make-sphere 44))
  (setq v-list (list (z-mul (car (send b1 :vertices)) 0.78)))
  (dolist (x (cdr (send b1 :vertices))) (setq v-list (append v-list (list (z-mul x 0.78)))))
  (setq b1 (convex-hull-3d v-list))

  ;; b1 is inside elliptical sphere, and b2 is leather of onion.
  (setq b2 (body- b2 b1))
  (send b1 :assoc b2)

  ;; (setq b3 (make-cylinder 8 2))
  ;; (setq v-list (list (car (send b3 :vertices))))
  ;; (dolist (x (cdr (send b3 :vertices))) (if (< (elt x 2) 1) (setq v-list (append v-list (list x)))))
  (setq v-list (list #f(6.9282 -4.0 0.0) #f(4.0 -6.9282 0.0) #f(-1.376677e-14 -8.0 0.0) #f(-4.0 -6.9282 0.0) #f(-6.9282 -4.0 0.0) #f(-8.0 8.437695e-15 0.0) #f(-6.9282 4.0 0.0) #f(-4.0 6.9282 0.0) #f(3.996803e-15 8.0 0.0) #f(4.0 6.9282 0.0) #f(6.9282 4.0 0.0) #f(8.0 0.0 0.0)))
  (setq b4 (make-cone #f(0 0 20) v-list))
  (send b4 :translate #f(0 0 28))

  ;; (setq b3 (make-cylinder 7 2))
  ;; (setq v-list (list (car (send b3 :vertices))))
  ;; (dolist (x (cdr (send b3 :vertices))) (if (< (elt x 2) 1) (setq v-list (append v-list (list x)))))
  (setq v-list (list #f(6.06218 -3.5 0.0) #f(3.5 -6.06218 0.0) #f(-1.110223e-14 -7.0 0.0) #f(-3.5 -6.06218 0.0) #f(-6.06218 -3.5 0.0) #f(-7.0 7.105427e-15 0.0) #f(-6.06218 3.5 0.0) #f(-3.5 6.062 0.0) #f(3.552714e-15 7.0 0.0) #f(3.5 6.06218 0.0) #f(6.06218 3.5 0.0) #f(7.0 0.0 0.0)))
  (setq b3 (make-cone #f(0 0 19) v-list))
  (send b3 :translate #f(0 0 28))

  ;; b3 is inside cone, and b4 is leather of onion.
  (setq b4 (body- b4 b3))
  (send b3 :assoc b4)

  (send b1 :assoc b3)

  ;; b5 is cube for body-
  (setq b5 (make-cube 100 100 100))
  (send b5 :translate #f(0 -50 0))

  (send b1 :translate #f(0 1 0))

  ;; definiton tmp bodies
  (setq t1-1 (body- b1 b5))
  (setq t1-2 (body- b2 b5))
  (setq t1-3 (body- b3 b5))
  (setq t1-4 (body- b4 b5))

  (setq t2-1 (body- b1 t1-1))
  (setq t2-2 (body- b2 t1-2))
  (setq t2-3 (body- b3 t1-3))
  (setq t2-4 (body- b4 t1-4))

  (send b5 :translate #f(0 50 -25))

  ;; start making parts of onion
  (setq p1-1 (body- t1-1 b5))
  (setq p1-2 (body- t1-2 b5))
  (setq t3-1 (body- t1-1 p1-1))
  (setq t3-2 (body- t1-2 p1-2))
  (setq p1-3 t1-3)
  (setq p1-4 t1-4)
  (send p1-1 :assoc p1-2)
  (send p1-1 :assoc p1-3)
  (send p1-3 :assoc p1-4)

  (setq p2-1 (body- t2-1 b5))
  (setq p2-2 (body- t2-2 b5))
  (setq t4-1 (body- t2-1 p2-1))
  (setq t4-2 (body- t2-2 p2-2))
  (setq p2-3 t2-3)
  (setq p2-4 t2-4)
  (send p2-1 :assoc p2-2)
  (send p2-1 :assoc p2-3)
  (send p2-3 :assoc p2-4)

  (send b5 :translate #f(0 0 -50))

  (setq p3-1 (body- t3-1 b5))
  (setq p3-2 (body- t3-2 b5))
  (setq p5-1 (body- t3-1 p3-1))
  (setq p5-2 (body- t3-2 p3-2))
  (send p3-1 :assoc p3-2)
  (send p5-1 :assoc p5-2)

  (setq p4-1 (body- t4-1 b5))
  (setq p4-2 (body- t4-2 b5))
  (setq p6-1 (body- t4-1 p4-1))
  (setq p6-2 (body- t4-2 p4-2))
  (send p4-1 :assoc p4-2)
  (send p6-1 :assoc p6-2)

  ;; set colors
  (send p1-2 :set-color :peru)
  (send p1-4 :set-color :peru)
  (send p2-2 :set-color :peru)
  (send p2-4 :set-color :peru)
  (send p3-2 :set-color :peru)
  (send p4-2 :set-color :peru)
  (send p5-2 :set-color :peru)
  (send p6-2 :set-color :peru)


  (send p1-1 :set-color :beige)
  (send p1-3 :set-color :beige)
  (send p2-1 :set-color :beige)
  (send p2-3 :set-color :beige)
  (send p3-1 :set-color :beige)
  (send p4-1 :set-color :beige)
  (send p5-1 :set-color :beige)
  (send p6-1 :set-color :beige)

  (setq *cut-point-1* (make-cascoords :pos #f(0 0 -30)))
  (setq *cut-point-2* (make-cascoords :pos #f(0 0 25)))
  (send *cut-point-2* :rotate (deg2rad -90) :x)
  (send *cut-point-2* :rotate (deg2rad 180) :z :world)
  (setq *cut-point-3* (make-cascoords :pos #f(0 0 -25)))
  (send *cut-point-3* :rotate (deg2rad -90) :x)
  (send *cut-point-3* :rotate (deg2rad 180) :z :world)
  (send *cut-point-3* :rotate (deg2rad 180) :z)

  (setq *cut-point-4* (make-cascoords :pos #f(0 0 25)))
  (send *cut-point-4* :rotate (deg2rad -90) :x)
  (setq *cut-point-5* (make-cascoords :pos #f(0 0 -25)))
  (send *cut-point-5* :rotate (deg2rad -90) :x)
  (send *cut-point-5* :rotate (deg2rad 180) :z)

  (send p3-1 :assoc *cut-point-1*)
  (send p2-1 :assoc *cut-point-2*)
  (send p4-1 :assoc *cut-point-3*)
  (send p1-1 :assoc *cut-point-4*)
  (send p3-1 :assoc *cut-point-5*)

  ;; test codes
  (send p4-1 :assoc p2-1)
  (send p4-1 :assoc p6-1)
  (send p3-1 :assoc p1-1)
  (send p3-1 :assoc p5-1)
  (send p3-1 :assoc p4-1)

  (setq *onion* (make-cascoords))
  (send *onion* :assoc p3-1)
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

(make-onion)
(send *onion* :translate #f(530 -120 860))
(objects (list *robot* p1-1 p1-2 p1-3 p1-4 p2-1 p2-2 p2-3 p2-4 p3-1 p3-2 p4-1 p4-2 p5-1 p5-2 p6-1 p6-2 *peeler* *cutting-board* *knife*))

(send *robot* :rotate (deg2rad -45) :z)
(send *robot* :reset-manip-pose)
(send *robot* :torso_lift_joint :joint-angle 325)
(send *robot* :head :look-at (send *cutting-board* :worldpos))


(send *arrow* :newcoords (send *onion* :copy-worldcoords))
(send *arrow* :rotate (deg2rad 90) :y)
(send *arrow* :translate #f(0 20 0) :world)
(send *arrow* :rotate (deg2rad -45) :x :world)
(send *arrow* :rotate (deg2rad -90) :x)

(send *robot* :rarm :inverse-kinematics
      (car (send *knife* :handle))
      :rotation-axis t
      :debug-view t)
(send (send *robot* :rarm :end-coords) :assoc *knife*)


(defun cut-set-move (*target*)
  (send *arrow* :newcoords (send *target* :copy-worldcoords))
  (send *arrow* :translate #f(0 0 60))

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
  (send (send *robot* :larm :end-coords) :assoc *onion*)

  (cut-set-move *cut-point-1*)
  (unix:usleep 100000)

  (format t ";; please run (cut-onion-1)~%")
  )

(defun cut-onion-1 ()
  (cut-move *cut-point-1*)

  (send p3-1 :dissoc p4-1)

  (send p4-1 :translate #f(0 -40 0) :world)
  (send *viewer* :draw-objects)
  (unix:usleep 100000)

  (format t ";; please run (set-move-2)~%")
  )

(defun set-move-2 ()
  (send *arrow* :newcoords (make-coords :pos #f(520 -300 1030)))
  (send *robot* :rarm :inverse-kinematics *arrow* :rotation-axis nil :debug-view t)
  (unix:usleep 100000)

  (send *arrow* :newcoords (make-coords :pos #f(600.0 -30.0 835.0) :rpy #f(-1.571 -0.0 1.571)))
  (send *robot* :larm :inverse-kinematics
	*arrow*
	:move-target p3-1
	:rotation-axis t
	:debug-view t)

  (send *robot* :larm :end-coords :dissoc *onion*)
  (unix:usleep 100000)

  (send *arrow* :newcoords (send p4-1 :copy-worldcoords))
  (send *arrow* :translate #f(0 -20 30))
  (send *arrow* :rotate (deg2rad 90) :y)
  (send *arrow* :rotate (deg2rad 90) :x)
  (send *arrow* :rotate (deg2rad 45) :y)

  (send *robot* :larm :inverse-kinematics *arrow* :debug-view t)
  (send *robot* :larm :end-coords :assoc p4-1)
  (unix:usleep 100000)

  (send *arrow* :newcoords (make-coords :pos #f(560.0 -150.0 835.0) :rpy #f(0 0 -1.571)))
  (send *robot* :larm  :inverse-kinematics
  	*arrow*
  	:move-target p4-1
  	:rotation-axis t
  	:debug-view t)
  (unix:usleep 100000)

  (cut-set-move *cut-point-3*)
  (unix:usleep 100000)
  
  (format t ";; please run (cut-onion-2)~%")
  )


(defun cut-onion-2 ()
  (cut-move *cut-point-3*)
  
  (send p4-1 :dissoc p6-1)

  (send p6-1 :translate #f(0 -30 0) :world)
  (send *viewer* :draw-objects)
  (unix:usleep 100000)

  (format t ";; please run (set-move-3)~%")
  )

(defun set-move-3 ()
  (send *arrow* :newcoords (make-coords :pos #f(520 -300 1030)))
  (send *robot* :rarm :inverse-kinematics *arrow* :rotation-axis nil :debug-view t)
  (unix:usleep 100000)

  (send *robot* :larm :end-coords :dissoc p4-1)
  
  (send *arrow* :newcoords (send p4-1 :copy-worldcoords))
  (send *arrow* :rotate (deg2rad 90) :z)
  (send *arrow* :rotate (deg2rad 90) :x)

  (send *robot* :larm :inverse-kinematics
	*arrow*
	:rotation-axis t
	:debug-view t)
  (send *robot* :larm :end-coords :assoc p4-1)
  (unix:usleep 100000)

  (send *arrow* :newcoords (send p4-1 :copy-worldcoords))
  (send *arrow* :rotate (deg2rad 180) :z :world)
  (send *robot* :larm :inverse-kinematics
	*arrow*
	:move-target p4-1
	:rotation-axis t
	:debug-view t)
  (send *robot* :larm :end-coords :dissoc p4-1)
  (unix:usleep 100000)

  (send *arrow* :newcoords (send p4-1 :copy-worldcoords))
  (send *arrow* :rotate (deg2rad 90) :z)
  (send *arrow* :translate #f(-10 0 -20))
  (send *arrow* :rotate (deg2rad -45) :y)
  
  (send *robot* :larm :inverse-kinematics
	*arrow*
	:rotation-axis t
	:debug-view t)
  (send *robot* :larm :end-coords :assoc p4-1)
  (unix:usleep 100000)

  (cut-set-move *cut-point-2*)
  (unix:usleep 100000)
  
  (format t ";; please run (cut-onion-3)~%")
  )

(defun cut-onion-3 ()
  (cut-move *cut-point-2*)

  (send p4-1 :dissoc p2-1)
  (send p2-1 :translate #f(0 -10 0) :world)
  (send *viewer* :draw-objects)
  (unix:usleep 100000)

  (format t ";; please run (set-move-4)~%")
  )

(defun set-move-4 ()
  (send *arrow* :newcoords (make-coords :pos #f(520 -300 1030)))
  (send *robot* :rarm :inverse-kinematics *arrow* :rotation-axis nil :debug-view t)
  (unix:usleep 100000)

  (send *robot* :larm :end-coords :dissoc p4-1)

  (send *arrow* :newcoords (send p3-1 :copy-worldcoords))
  (send *arrow* :rotate (deg2rad -90) :x)
  (send *arrow* :rotate (deg2rad 90) :y)

  (send *robot* :larm  :inverse-kinematics
  	*arrow*
  	:rotation-axis t
  	:debug-view t)
  (unix:usleep 100000)

  (send *robot* :larm :end-coords :assoc p3-1)
  
  (send *arrow* :newcoords (make-coords :pos #f(560.0 -50.0 835.0) :rpy #f(0 0 1.571)))
  (send *robot* :larm  :inverse-kinematics
  	*arrow*
  	:move-target p3-1
  	:rotation-axis t
  	:debug-view t)
  (unix:usleep 100000)

  (send *robot* :larm :end-coords :dissoc p3-1)
  
  (send *arrow* :newcoords (send p3-1 :copy-worldcoords))
  (send *arrow* :rotate (deg2rad -90) :z)
  (send *arrow* :translate #f(-10 0 -20))
  (send *arrow* :rotate (deg2rad -45) :y)

  (send *robot* :larm :inverse-kinematics
	*arrow*
	:rotation-axis t
	:debug-view t)
  (send *robot* :larm :end-coords :assoc p3-1)
  (unix:usleep 100000)

  
  (cut-set-move *cut-point-4*)
  (unix:usleep 100000)
  
  (format t ";; please run (cut-onion-4)~%")
  )

(defun cut-onion-4 ()
  (cut-move *cut-point-4*)

  (send p3-1 :dissoc p1-1)

  (send p1-1 :translate #f(0 -20 0) :world)
  (send *viewer* :draw-objects)
  (unix:usleep 100000)

  (format t ";; please run (set-move-5)~%")
  )

(defun set-move-5 ()
  (send *arrow* :newcoords (make-coords :pos #f(520 -300 1030)))
  (send *robot* :rarm :inverse-kinematics *arrow* :rotation-axis nil :debug-view t)
  (unix:usleep 100000)

  (send *robot* :larm :end-coords :dissoc p3-1)

  (send *arrow* :newcoords (send p3-1 :copy-worldcoords))
  (send *arrow* :rotate (deg2rad -90) :x)
  (send *arrow* :rotate (deg2rad 90) :y)

  (send *robot* :larm :inverse-kinematics
  	*arrow*
  	:rotation-axis t
  	:debug-view t)
  (send *robot* :larm :end-coords :assoc p3-1)
  (unix:usleep 100000)

  (send *arrow* :newcoords (send p3-1 :copy-worldcoords))
  (send *arrow* :rotate (deg2rad 180) :z :world)
  (send *robot* :larm :inverse-kinematics
  	*arrow*
  	:move-target p3-1
  	:rotation-axis t
  	:debug-view t)
  (send *robot* :larm :end-coords :dissoc p3-1)
  (unix:usleep 100000)
  
  (send *arrow* :newcoords (send p3-1 :copy-worldcoords))
  (send *arrow* :rotate (deg2rad 90) :y)
  (send *arrow* :rotate (deg2rad -90) :x)
  (send *arrow* :translate #f(-20 0 10))
  (send *arrow* :rotate (deg2rad 45) :y)
  
  (send *robot* :larm :inverse-kinematics
  	*arrow*
  	:rotation-axis t
  	:debug-view t)
  (send *robot* :larm :end-coords :assoc p3-1)
  (unix:usleep 100000)

  (cut-set-move *cut-point-5*)
  (unix:usleep 100000)
  
  (format t ";; please run (cut-onion-5)~%")
  )

(defun cut-onion-5 ()
  (cut-move *cut-point-5*)

  (send p3-1 :dissoc p5-1)
  (send p5-1 :translate #f(0 -10 0) :world)
  (send *viewer* :draw-objects)
  (unix:usleep 100000)

  (format t ";; please run (set-move-6)~%")
  )

(defun set-move-6 ()
  (send *arrow* :newcoords (make-coords :pos #f(520 -300 1030)))
  (send *robot* :rarm :inverse-kinematics *arrow* :rotation-axis nil :debug-view t)
  (unix:usleep 100000)

  (send *arrow* :newcoords (make-coords :pos #f(600.0 -30.0 835.0) :rpy #f(-1.571 -0.0 1.571)))
  (send *robot* :larm :inverse-kinematics
	*arrow*
	:move-target p3-1
	:rotation-axis t
	:debug-view t)

  (send *robot* :larm :end-coords :dissoc p3-1)
  (unix:usleep 100000)

  (send *arrow* :newcoords (send p4-1 :copy-worldcoords))
  (send *arrow* :rotate (deg2rad 90) :z)
  (send *arrow* :rotate (deg2rad -90) :x)

  (send *robot* :larm :inverse-kinematics
	*arrow*
	:rotation-axis t
	:debug-view t)
  (send *robot* :larm :end-coords :assoc p4-1)

  (send *arrow* :newcoords (make-coords :pos #f(530.0 -30.0 835.0) :rpy #f(-1.571 -0.0 -1.571)))
  (send *robot* :larm :inverse-kinematics
	*arrow*
	:move-target p4-1
	:rotation-axis t
	:debug-view t)

  (send *robot* :larm :end-coords :dissoc p4-1)
  (unix:usleep 100000)

  )



(format t ";; please run (set-move-1)~%")
(format t ";; you can also run (now-devel) or (exec-all)~%")

(defun now-devel ()
  (set-move-1)
  (cut-onion-1)
  (set-move-2)
  (cut-onion-2)
  (set-move-3)
  (cut-onion-3)
  (set-move-4)
  (cut-onion-4)
  (set-move-5)
  (cut-onion-5)
  )

(defun exec-all ()
  (set-move-1)
  (cut-onion-1)
  (set-move-2)
  (cut-onion-2)
  (set-move-3)
  (cut-onion-3)
  (set-move-4)
  (cut-onion-4)
  (set-move-5)
  (cut-onion-5)
  (set-move-6)
  )
  
