(load "../../model/my-room73b2-scene.l")
(setq *room* (room73b2))

(load "models/room73b2-kitchen-object.l")
(setq *kitchen* (room73b2-kitchen))
(send *kitchen* :transform (make-coords :pos (float-vector 305.0 2175.0 0.0) :rot #2f((1.0 2.449294e-16 0.0) (-2.449294e-16 1.0 0.0) (0.0 0.0 1.0))))

(load "package://pr2eus/pr2-interface.l")
(pr2-init)


 ;; set まな板
(load "../../model/cutting-board.l")
(setq *cutting-board* (cutting-board))
(send *cutting-board* :transform (make-coords :pos (float-vector 500.0 2000.0 820.0) :rot #2f((1.0 2.449294e-16 0.0) (-2.449294e-16 1.0 0.0) (0.0 0.0 1.0))))

;; set objects
(load "../../model/carrot-test-model.l")
(load "../../model/peeler.l")
(load "../../model/my-knife.l")
(load "models/arrow-object.l")

;; set spots
(setq *cook-spot* (send *room73b2* :spot "cook-spot"))
(setq *sink-spot* (make-coords :pos #f(1055 2600 0) :rpy #f(3.14 0 0))) 
(setq *kitchen-spot* (send *room73b2* :spot "kitchen-spot"))


;; キッチンの場所まで移動 (初期値)
(defun move-to-kitchen-irt ()
  (send *pr2* :move-to *kitchen-spot* :world)
  )
(move-to-kitchen-irt)
(send *pr2* :reset-manip-pose)
(send *pr2* :torso_lift_joint :joint-angle 325)

(objects (list *kitchen* *pr2* *cutting-board*))
(send *irtviewer* :look-all
      (geo::make-bounding-box 
       (flatten (send-all (send *pr2* :bodies) :vertices))))

;; def global values
(setq s-time 4)

(setq width 100)
(setq length 60)
(setq height 50)

(warn "please run (set-carrot) or (now-devel)~%")

(defun set-carrot ()

  (setq *carrot* (carrot))
  (send *carrot* :transform (make-coords :pos (float-vector 500.0 1910.0 (+ 830.0 (/ height 2))) :rot #2f((1.194340e-15 -1.0 0.0) (1.0 1.194340e-15 0.0) (0.0 0.0 1.0))))
  (send *carrot* :cut)
  
  (objects (list *kitchen* *pr2* *cutting-board* *carrot*))
  (send *irtviewer* :look-all
	(geo::make-bounding-box 
	 (flatten (send-all (send *pr2* :bodies) :vertices))))

  (warn "please run (set-knife) ~%")
  )


(defun set-knife-ver ()
  ;; set pose
  (send *pr2* :reset-manip-pose)
  (send *pr2* :torso_lift_joint :joint-angle 325)
  (send *viewer* :draw-objects)
  (send *ri* :angle-vector (send *pr2* :angle-vector) 4000)
  (send *ri* :wait-interpolation)

  ;; grasp knife
  (send *ri* :stop-grasp :rarm :wait t)
  (send *ri* :speak-jp "包丁を握らせて下さい")
  (unix:sleep s-time)
  ;; (send *ri* :start-grasp :rarm :wait t)
  (send *ri* :start-grasp :rarm :wait t :gain 100)

  (setq *knife* (knife))
  (send *knife* :newcoords (send (send *pr2* :rarm :end-coords) :copy-worldcoords))
  (send *pr2* :rarm :end-coords :assoc *knife*)

  (objects (list *kitchen* *pr2* *cutting-board* *carrot* *knife*))
  (send *irtviewer* :look-all
	(geo::make-bounding-box 
	 (flatten (send-all (send *pr2* :bodies) :vertices))))

  (warn "please run (set-larm) ~%")
  )

(defun set-larm ()
  (setq *arrow* (arrow))

  (send *arrow* :newcoords (send (send *pr2* :larm :end-coords) :copy-worldcoords))
  (send *arrow* :translate #f(0 0 200) :world)
  (send *pr2* :larm :inverse-kinematics
	(send *arrow* :copy-worldcoords)
	:rotation-axis nil
	:debug-view t)
  (send *viewer* :draw-objects)
  (send *ri* :angle-vector (send *pr2* :angle-vector) 4000)
  (send *ri* :wait-interpolation)

  (objects (list *kitchen* *pr2* *cutting-board* *carrot* *knife* *arrow*))
  (send *irtviewer* :look-all
	(geo::make-bounding-box 
	 (flatten (send-all (send *pr2* :bodies) :vertices))))

  (send *arrow* :newcoords (send *carrot* :copy-worldcoords))
  (send *arrow* :rotate (deg2rad 20) :y)

  (send *ri* :stop-grasp :larm :wait t)
  (send *arrow* :translate #f(0 -100 100) :world)
  (send *pr2* :larm :inverse-kinematics (send *arrow* :copy-worldcoords))
  (send *viewer* :draw-objects)
  (send *ri* :angle-vector (send *pr2* :angle-vector) 4000)
  (send *ri* :wait-interpolation)

  (send *arrow* :translate #f(0 70 -100) :world)
  (send *pr2* :larm :inverse-kinematics (send *arrow* :copy-worldcoords))
  (send *viewer* :draw-objects)
  (send *ri* :angle-vector (send *pr2* :angle-vector) 4000)
  (send *ri* :wait-interpolation)
  (send *ri* :start-grasp :larm :wait t)

  (warn "please run (cut-test3) ~%")  
  )

(defun cut-test3 ()
  (if (not (boundp '*carrot*))
      (set-carrot))

  ;; 少し上に包丁を
  (send *arrow* :newcoords (send *cut-point-1* :copy-worldcoords))
  (send *arrow* :translate (float-vector 0 0 (* height 1)))  
  (send *pr2* :rarm :inverse-kinematics
	*arrow*
	:move-target (car (send *knife* :attention))
	:rotation-axis t
	:debug-view t)
  (send *viewer* :draw-objects)
  (send *ri* :angle-vector (send *pr2* :angle-vector) 4000)
  (send *ri* :wait-interpolation)

  (setq interval 10)
  (dotimes (i (+ (round (/ height interval)) 2))
    (send *arrow* :translate (float-vector interval 0 (/ interval -2)))
    (send *pr2* :rarm :inverse-kinematics
	  *arrow*
	  :move-target (car (send *knife* :attention))
	  :rotation-axis t
	  :debug-view t)
    (send *viewer* :draw-objects)
    (send *ri* :angle-vector (send *pr2* :angle-vector) 1000)
    (send *ri* :wait-interpolation)

    (send *arrow* :translate (float-vector (* interval -1) 0 (/ interval -2)))
    (send *pr2* :rarm :inverse-kinematics
	  *arrow*
	  :move-target (car (send *knife* :attention))
	  :rotation-axis t
	  :debug-view t)
    (send *viewer* :draw-objects)
    (send *ri* :angle-vector (send *pr2* :angle-vector) 1000)
    (send *ri* :wait-interpolation)

    )
  
  (warn "you can retry (cut-test1) , (cut-test2) , (cut-test3) or you want to finish please run (finish) ~%")
  (warn "(move-carrot)~&")
  )

(defun move-carrot ()
  (send c2-1-1 :dissoc c1)
  (send c1 :translate #f(0 100 0) :world)
  (send *viewer* :draw-objects)

  (send *arrow* :newcoords (send (car (send *knife* :attention)) :copy-worldcoords))
  (send *arrow* :translate #f(0 0 100) :world)
  (send *pr2* :rarm :inverse-kinematics
	*arrow*
	:move-target (car (send *knife* :attention))
	:rotation-axis nil
	:debug-view t)
  (send *viewer* :draw-objects)
  (send *ri* :angle-vector (send *pr2* :angle-vector) 1000)
  (send *ri* :wait-interpolation)
    
  (warn "(change-peeler)~&")
  )

(defun change-peeler ()
  ;; set pose
  (send *arrow* :newcoords (make-coords :pos #f(700.191 2189.104 866.677) :rpy #f(-2.341 -0.222 -0.482)))
  (send *pr2* :rarm :inverse-kinematics
	*arrow*
	:rotation-axis t
	:debug-view t)
  (send *viewer* :draw-objects)
  (send *ri* :angle-vector (send *pr2* :angle-vector) 1000)
  (send *ri* :wait-interpolation)  

  (send *pr2* :rarm :end-coords :dissoc *knife*)
  (send *ri* :stop-grasp :rarm :wait t)
  
  ;; grasp knife
  (send *ri* :speak-jp "ピーラーを握らせて下さい")
  (unix:sleep s-time)
  (send *ri* :start-grasp :rarm :wait t :gain 100)

  (setq *peeler* (peeler))
  (send *peeler* :newcoords (send (send *pr2* :rarm :end-coords) :copy-worldcoords))
  (send *pr2* :rarm :end-coords :assoc *peeler*)

  (objects (list *kitchen* *pr2* *cutting-board* *carrot* *peeler*))
  (send *irtviewer* :look-all
	(geo::make-bounding-box 
	 (flatten (send-all (send *pr2* :bodies) :vertices))))

  (warn "please run (peel-test) ~%")
  )

(defun peel-test ()

  (setq *larm-peel-coords* (send (send *pr2* :larm :end-coords) :copy-worldcoords))
  
  (send *arrow* :newcoords (send (send *pr2* :larm :end-coords) :copy-worldcoords))
  (send *arrow* :rotate (deg2rad 180) :z)
  (send *arrow* :translate (float-vector 0 0 (* 1 height)) :world)
  (send *arrow* :rotate (deg2rad 20) :y)
  
  (send *pr2* :rarm :inverse-kinematics
	*arrow*
	:move-target (car (send *peeler* :attention))
	:rotation-axis t
	:debug-view t)
  (send *viewer* :draw-objects)
  (send *ri* :angle-vector (send *pr2* :angle-vector) 4000)
  (send *ri* :wait-interpolation)

  ;; 皮剥き始める所
  (send *arrow* :translate (float-vector 0 0 (* -1 height)) :world)
  (send *pr2* :rarm :inverse-kinematics
	*arrow*
	:move-target (car (send *peeler* :attention))
	:rotation-axis t
	:debug-view t)
  (send *viewer* :draw-objects)
  (send *ri* :angle-vector (send *pr2* :angle-vector) 4000)
  (send *ri* :wait-interpolation)

  ;; 剥き終わり
  (send *arrow* :translate (float-vector 0 (* (+ width 20) 1) 0) :world)
  (send *pr2* :rarm :inverse-kinematics
	*arrow*
	:move-target (car (send *peeler* :attention))
	:rotation-axis t
	:debug-view t)
  (send *viewer* :draw-objects)
  (send *ri* :angle-vector (send *pr2* :angle-vector) 4000)
  (send *ri* :wait-interpolation)
  
  (warn "you can retry (peel-test) or (finish-pose)~%")
  )

(defun finish-pose ()
  ;; set pose
  (send *arrow* :newcoords (make-coords :pos #f(700.191 2189.104 866.677) :rpy #f(-2.341 -0.222 -0.482)))
  (send *pr2* :rarm :inverse-kinematics
	*arrow*
	:rotation-axis t
	:debug-view t)
  (send *viewer* :draw-objects)
  (send *ri* :angle-vector (send *pr2* :angle-vector) 1000)
  (send *ri* :wait-interpolation)  

  (warn "please run (put-carrot)~%")
  )

(defun put-carrot ()
  (send *pr2* :larm :end-coords :assoc *carrot*)
  
  (send *arrow* :newcoords (send (send *pr2* :larm :end-coords) :copy-worldcoords))
  (send *arrow* :translate #f(0 0 150) :world)
  (send *pr2* :larm :inverse-kinematics
	(send *arrow* :copy-worldcoords)
	:rotation-axis t
	:debug-view t)
  (send *viewer* :draw-objects)
  (send *ri* :angle-vector (send *pr2* :angle-vector) 4000)
  (send *ri* :wait-interpolation)

  (send *arrow* :newcoords (send *cut-point-1* :copy-worldcoords))
  (send *arrow* :translate #f(0 0 -170) :world)
  (send *arrow* :rotate (deg2rad 90) :x)
  (send *pr2* :larm :inverse-kinematics
	(send *arrow* :copy-worldcoords)
	:move-target *cut-point-1*
	:rotation-axis t
	:debug-view t)
  (send *viewer* :draw-objects)
  (send *ri* :angle-vector (send *pr2* :angle-vector) 4000)
  (send *ri* :wait-interpolation)

  (setq *larm-put-coords* (send (send *pr2* :larm :end-coords) :copy-worldcoords))
  (send *carrot* :worldcoords)

  (send *ri* :stop-grasp :larm :wait t)
  (send *pr2* :larm :end-coords :dissoc *carrot*)
  
  (send *arrow* :newcoords (make-coords :pos (send (send *carrot* :copy-worldcoords) :worldpos)))
  (send *arrow* :rotate (deg2rad 90) :z)
  (send *arrow* :translate #f(0 -100 100) :world)
  (send *pr2* :larm :inverse-kinematics
  	(send *arrow* :copy-worldcoords)
  	:rotation-axis t
  	:debug-view t)
  (send *viewer* :draw-objects)
  (send *ri* :angle-vector (send *pr2* :angle-vector) 4000)
  (send *ri* :wait-interpolation)

  (setq *larm-wait-coords* (send (send *pr2* :larm :end-coords) :copy-worldcoords))
  
  (warn "please run (next-grasp)~&")
  )

(defun next-grasp ()
  ;;
  (send *arrow* :newcoords (send *carrot* :copy-worldcoords))
  (send *arrow* :rotate (deg2rad 20) :y)
  (send *arrow* :translate #f(0 0 30) :world)
  (send *arrow* :rotate (deg2rad -30) :z :world)

  (send *pr2* :larm :inverse-kinematics (send *arrow* :copy-worldcoords))
  (send *viewer* :draw-objects)
  (send *ri* :angle-vector (send *pr2* :angle-vector) 4000)
  (send *ri* :wait-interpolation)

  (setq *larm-grasp-coords* (send (send *pr2* :larm :end-coords) :copy-worldcoords))
  (send (send *pr2* :larm :end-coords) :assoc *carrot*)
  (send *ri* :stop-grasp :larm :wait t)
  
  (warn "please run (set-peel)~&")
  )

(defun set-peel ()
  (send *arrow* :newcoords (send *larm-peel-coords* :copy-worldcoords))
  (send *arrow* :translate #f(0 0 100) :world)
  (send *pr2* :larm :inverse-kinematics (send *arrow* :copy-worldcoords) :debug-view t)
  (send *viewer* :draw-objects)
  (send *ri* :angle-vector (send *pr2* :angle-vector) 4000)
  (send *ri* :wait-interpolation)

  (send *arrow* :translate #f(0 0 -100) :world)
  (send *pr2* :larm :inverse-kinematics (send *arrow* :copy-worldcoords) :debug-view t)
  (send *viewer* :draw-objects)
  (send *ri* :angle-vector (send *pr2* :angle-vector) 4000)
  (send *ri* :wait-interpolation)
 
  (warn "please run (peel-test2)~&")
  )

(defun peel-test2 ()
  (peel-test)

  (warn "please run (finish-pose2)~&")
  )

(defun finish-pose2 ()
  (finish-pose)
  (warn "please run (put-carrot2)~&")  
  )

(defun put-carrot2 ()
  (send *pr2* :larm :end-coords :assoc *carrot*)
  
  (send *arrow* :newcoords (send (send *pr2* :larm :end-coords) :copy-worldcoords))
  (send *arrow* :translate #f(0 0 150) :world)
  (send *pr2* :larm :inverse-kinematics
	(send *arrow* :copy-worldcoords)
	:rotation-axis t
	:debug-view t)
  (send *viewer* :draw-objects)
  (send *ri* :angle-vector (send *pr2* :angle-vector) 4000)
  (send *ri* :wait-interpolation)

  (send *arrow* :newcoords (send *larm-put-coords* :copy-worldcoords))
  (send *pr2* :larm :inverse-kinematics
	(send *arrow* :copy-worldcoords)
	:rotation-axis t
	:debug-view t)
  (send *viewer* :draw-objects)
  (send *ri* :angle-vector (send *pr2* :angle-vector) 4000)
  (send *ri* :wait-interpolation)

  (send *ri* :stop-grasp :larm :wait t)
  (send *pr2* :larm :end-coords :dissoc *carrot*)
  
  (send *arrow* :newcoords (send *larm-wait-coords* :copy-worldcoords))
  (send *pr2* :larm :inverse-kinematics
  	(send *arrow* :copy-worldcoords)
  	:rotation-axis t
  	:debug-view t)
  (send *viewer* :draw-objects)
  (send *ri* :angle-vector (send *pr2* :angle-vector) 4000)
  (send *ri* :wait-interpolation)
  
  (warn "please run (next-grasp2)~&")
  )

(defun next-grasp2 ()
  (send *pr2* :larm :inverse-kinematics (send *larm-grasp-coords* :copy-worldcoords))
  (send *viewer* :draw-objects)
  (send *ri* :angle-vector (send *pr2* :angle-vector) 4000)
  (send *ri* :wait-interpolation)

  (send (send *pr2* :larm :end-coords) :assoc *carrot*)
  (send *ri* :stop-grasp :larm :wait t)
  
  (warn "please run (set-peel2)~&")  
  )

(defun set-peel2 ()
  (set-peel)
  
  (warn "please run (peel-test2)~&")
  )

(set-carrot)
(set-knife-ver)
(set-larm)
(cut-test3)
(move-carrot)
(change-peeler)
(peel-test)
(finish-pose)
(put-carrot)
(next-grasp)
(set-peel)

