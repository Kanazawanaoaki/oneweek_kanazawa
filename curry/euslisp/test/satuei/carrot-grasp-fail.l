;; robot initialize
(load "package://pr2eus/pr2-interface.l")   
(pr2-init)

;; set knife
;; (load "../../model/my-knife.l")
(load "../../model/knife-new-attention.l")
(setq *knife* (knife))
(send *knife* :locate #f(500 -400 830))

;; set まな板
(load "../../model/cutting-board.l")
(setq *cutting-board* (cutting-board))
(send *cutting-board* :locate #f(650 0 825))

;; set arrow
(load "models/arrow-object.l")
(setq *arrow* (arrow))

;; ;; set potato
;; (load "../../model/potato-test-model.l")
;; (setq *potato* (potato))
;; (send *potato* :cut)
;; (send *potato* :translate #f(620 -160 850))
;; (send *potato* :rotate (deg2rad -90) :z :world)
;; (objects (list *pr2* p1 p2 p3 p4 p5 p6 *knife* *cutting-board*))

;; set carrot
(load "../../model/carrot-test-new-type.l")
(setq width 160)
(setq length 40)
(setq height 40)
(setq *carrot* (carrot :w 160 :l 40 :h 40))
;; (setq *carrot* (carrot))
(send *carrot* :cut)
(send *carrot* :translate #f(650 0 850))
(send *carrot* :rotate (deg2rad -90) :z :world)
(objects (list *pr2* *carrot* *knife* *cutting-board*))


(send *pr2* :reset-manip-pose)
(send *pr2* :torso_lift_joint :joint-angle 325)

(send *pr2* :rarm :inverse-kinematics
      (car (send *knife* :handle))
      :rotation-axis t
      :debug-view t)
(send *arrow* :newcoords (send (car (send *knife* :handle)) :copy-worldcoords))
(send *arrow* :assoc *knife*)
(send *arrow* :translate #f(12 0 0))
(send *arrow* :rotate (deg2rad 90) :x)
(send *arrow* :dissoc *knife*)
(send (send *pr2* :rarm :end-coords) :assoc *knife*)

(warn "please run (grasp-carrot) or (now-test) ~%")


(defun grasp-carrot ()
  ;;少し上に
  (send *arrow* :newcoords (send (send *pr2* :larm :end-coords) :copy-worldcoords))
  (send *arrow* :translate #f(0 0 250) :world)
  (send *pr2* :larm :inverse-kinematics
	(send *arrow* :copy-worldcoords)
	:rotation-axis nil
	:debug-view t)
  (send *viewer* :draw-objects)
  (send *ri* :angle-vector (send *pr2* :angle-vector) 4000)
  (send *ri* :wait-interpolation)

  ;;gripperを開く
  (send *ri* :stop-grasp :larm :wait t)

    ;;人参の掴む所に
  (send *arrow* :newcoords (send *carrot* :copy-worldcoords))
  (send *arrow* :translate (float-vector (+ (/ width -2) 20) 0 0))
  ;; (send *arrow* :rotate (deg2rad 90) :y)
  (send *arrow* :rotate (deg2rad 60) :y)
  (send *arrow* :translate #f(0 0 100) :world)
  (send *pr2* :larm :inverse-kinematics
  	(send *arrow* :copy-worldcoords)
	:rotation-axis t
	:debug-view t)
  (send *viewer* :draw-objects)
  (send *ri* :angle-vector (send *pr2* :angle-vector) 4000)
  (send *ri* :wait-interpolation)

  (send *arrow* :translate #f(0 0 -100) :world)
  (send *pr2* :larm :inverse-kinematics
  	(send *arrow* :copy-worldcoords)
	:rotation-axis t
	:debug-view t)
  (send *viewer* :draw-objects)
  (send *ri* :angle-vector (send *pr2* :angle-vector) 4000)
  (send *ri* :wait-interpolation)

  ;;gripperを閉じる
  (send *ri* :start-grasp :larm :wait t)
  (send *pr2* :larm :end-coords :assoc *carrot*)
  (warn "please run (set-knife) ~%")
  )

(defun set-knife ()
  (send *arrow* :newcoords (send *cut-point-1* :copy-worldcoords))
  (send *arrow* :translate (float-vector 0 -30 (+ (* height 1) 10)))

  (send *pr2* :rarm :inverse-kinematics
	*arrow*
	:move-target (car (send *knife* :attention))
	:rotation-axis t
	:debug-view t)
  (send *viewer* :draw-objects)
  (send *ri* :angle-vector (send *pr2* :angle-vector) 4000)
  (send *ri* :wait-interpolation)

  (warn "please run (zurasu) ~%")  
  )


(defun zurasu ()
  (send *arrow* :newcoords (send *carrot* :copy-worldcoords))
  (send *arrow* :translate (float-vector (+ (/ width -2) 20) 0 0))
  (send *arrow* :assoc *carrot*)
  (send *arrow* :rotate (deg2rad -10) :z :world)
  (send *arrow* :dissoc *carrot*)

  (send (send *pr2* :rarm :end-coords) :dissoc *knife*)
  (send *arrow* :newcoords (send (car (send *knife* :handle)) :copy-worldcoords))
  (send *arrow* :assoc *knife*)
  (send *arrow* :rotate (deg2rad -3) :z :world)
  (send *arrow* :rotate (deg2rad -10) :x)
  (send *arrow* :dissoc *knife*)
  (send (send *pr2* :rarm :end-coords) :assoc *knife*)
  
  )

(defun now-test ()
  (grasp-carrot)
  (set-knife)
  (zurasu)
  )

(now-test)

(warn "please run (adjust) ~%")

(defun adjust ()
  (send *arrow* :newcoords (send *carrot* :copy-worldcoords))
  (send *arrow* :translate (float-vector (+ (/ width -2) 20) 0 0))

  (setq *arrow2* (arrow))
  (send *arrow2* :newcoords (send *carrot* :copy-worldcoords))
  (send *arrow* :assoc *arrow2*)
  (send *arrow* :rotate (deg2rad 10) :z :world)

  (send (send *pr2* :larm :end-coords) :assoc *carrot*)
  (send *pr2* :larm :inverse-kinematics
	*arrow2*
	:move-target *carrot*
	:rotation-axis t
	:debug-view t)

  
  (send *arrow* :newcoords (send *cut-point-1* :copy-worldcoords))
  (send *arrow* :translate (float-vector 0 -30 (+ (* height 1) 10)))
  (send *pr2* :rarm :inverse-kinematics
	*arrow*
	:move-target (car (send *knife* :attention))
	:rotation-axis t
	:debug-view t)
  (send *viewer* :draw-objects)
  (send *ri* :angle-vector (send *pr2* :angle-vector) 4000)
  (send *ri* :wait-interpolation)

  
  )
