(defun init ()
  (load "../../model/my-room73b2-scene.l")
  (setq *room* (room73b2))

  (load "models/room73b2-kitchen-object.l")
  (setq *kitchen* (room73b2-kitchen))
  (send *kitchen* :transform (make-coords :pos (float-vector 305.0 2175.0 20.0) :rot #2f((1.0 2.449294e-16 0.0) (-2.449294e-16 1.0 0.0) (0.0 0.0 1.0))))

  (load "package://pr2eus/pr2-interface.l")
  (pr2-init)
  ;; (pr2)


  ;; set まな板
  (load "../../model/cutting-board.l")
  (setq *cutting-board* (cutting-board))
  (send *cutting-board* :transform (make-coords :pos (float-vector 500.0 2000.0 840.0) :rot #2f((1.0 2.449294e-16 0.0) (-2.449294e-16 1.0 0.0) (0.0 0.0 1.0))))

  ;; set objects
  (load "../../model/peeler.l")
  (load "../../model/my-knife.l")
  (load "models/arrow-object.l")
  (setq *arrow* (arrow))

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
  (send *ri* :angle-vector (send *pr2* :angle-vector) 4000)
  (send *ri* :wait-interpolation)

  (objects (list *pr2* *cutting-board*))

  ;; def global values
  (setq s-time 2)

  ;; set potato
  ;; (load "../../model/potato-test-model.l")
  (load "../../model/potato-new-type.l")

  (setq width 90)
  (setq length 60)
  (setq height 60)
  )

(init)


(warn "please run (set-potato :w 90 :l 60 :h 60) or (now-devel)~%")

(defun set-potato (&rest args &key (w 90) (l 60) (h 60) &allow-other-keys)

  (setq width w)
  (setq length l)
  (setq height h)
  
  (setq *potato* (potato :w w :l l :h h))
  (send *potato* :transform (make-coords :pos (float-vector 500.0 2000.0 (+ 850.0 (/ h 2))) :rot #2f((1.194340e-15 -1.0 0.0) (1.0 1.194340e-15 0.0) (0.0 0.0 1.0))))
  (send *potato* :cut)
  
  (objects (list *kitchen* *pr2* *cutting-board* *potato*))
  (send *irtviewer* :look-all
	(geo::make-bounding-box 
	 (flatten (send-all (send *pr2* :bodies) :vertices))))

  (warn "please run (grasp-potato) ~%")
  )


(defun grasp-potato ()
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

  ;; じゃがいもの掴む所に
  (send *arrow* :newcoords (send *potato* :copy-worldcoords))
  ;; (send *arrow* :locate (float-vector (/ width -3) 0 0))
  (send *arrow* :rotate (deg2rad 30) :y)

  ;;gripperを開く
  (send *ri* :stop-grasp :larm :wait t)
  (send *arrow* :translate #f(0 -100 100) :world)
  (send *pr2* :larm :inverse-kinematics
  	(send *arrow* :copy-worldcoords)
	:rotation-axis t
	:debug-view t)
  (send *viewer* :draw-objects)
  (send *ri* :angle-vector (send *pr2* :angle-vector) 4000)
  (send *ri* :wait-interpolation)

  (send *arrow* :translate #f(0 100 -100) :world)
  (send *pr2* :larm :inverse-kinematics
  	(send *arrow* :copy-worldcoords)
	:rotation-axis t
	:debug-view t)
  (send *viewer* :draw-objects)
  (send *ri* :angle-vector (send *pr2* :angle-vector) 4000)
  (send *ri* :wait-interpolation)

  ;;gripperを閉じる
  (send *ri* :start-grasp :larm :wait t)
     
  (send *arrow* :newcoords (send *cut-point-1* :copy-worldcoords))
  (warn "please run  (set-knife-hor) ~%")
  )

(defun set-knife-hor ()

  ;; grasp knife
  (send *ri* :stop-grasp :rarm :wait t)
  (send *ri* :speak-jp "包丁を握らせて下さい")
  (unix:sleep s-time)
  (send *ri* :start-grasp :rarm :wait t :gain 100)
  
  (setq *knife* (knife))
  (send *knife* :newcoords (send (send *pr2* :rarm :end-coords) :copy-worldcoords))
  (send *knife* :rotate (deg2rad 90) :x)
  (send *pr2* :rarm :end-coords :assoc *knife*)

  (objects (list *kitchen* *pr2* *cutting-board* *potato* *knife*))
  (send *irtviewer* :look-all
	(geo::make-bounding-box 
	 (flatten (send-all (send *pr2* :bodies) :vertices))))

  (warn "please run (cut-test3) ~%")
  )

(defun cut-test3 ()
  (if (not (boundp '*potato*))
      (set-potato :w width :l length :h height))

  (send *arrow* :newcoords (send (send *pr2* :rarm :end-coords) :copy-worldcoords))
  (send *arrow* :translate #f(0 0 100) :world)
  (send *pr2* :rarm :inverse-kinematics
	(send *arrow* :copy-worldcoords)
	:rotation-axis nil
	:debug-view t)
  (send *viewer* :draw-objects)
  (send *ri* :angle-vector (send *pr2* :angle-vector) 4000)
  (send *ri* :wait-interpolation)


  ;; 少し上に包丁を

  (send *arrow* :newcoords (send *cut-point-1* :copy-worldcoords))
  (send *arrow* :translate (float-vector 0 0 (* height 1)))  

  ;; 少し上にするために
  (setq offset 10)
 
  (send *arrow* :translate (float-vector 0 0 offset))  
  (send *pr2* :rarm :inverse-kinematics
	*arrow*
	:move-target (car (send *knife* :attention))
	:rotation-axis t
	:debug-view t)
  (send *viewer* :draw-objects)
  (send *ri* :angle-vector (send *pr2* :angle-vector) 4000)
  (send *ri* :wait-interpolation)
  

  (send *arrow* :translate (float-vector 0 0 (* offset -1)))  
  (send *pr2* :rarm :inverse-kinematics
	*arrow*
	:move-target (car (send *knife* :attention))
	:rotation-axis t
	:debug-view t)
  (send *viewer* :draw-objects)
  (send *ri* :angle-vector (send *pr2* :angle-vector) 4000)
  (send *ri* :wait-interpolation)

  (setq interval 10)
  (dotimes (i (+ (round (/ height interval)) 1))
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
  
  (warn "you can retry (cut-test3), (continue-cut 4) or you want to finish please run (change-peeler)  ~%")
  )

(defun continue-cut (num)
  (setq interval 10)
  (dotimes (i num)
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
    (send *ri* :wait-interpolation))
  (warn "you can retry (cut-test3), (continue-cut 4) or you want to finish please run (change-peeler)  ~%")
  )

(defun move-potato-1 ()
  (send p4 :dissoc p7)
  (send p7 :translate #f(0 100 0) :world)
  (send *viewer* :draw-objects)

  )


(defun change-peeler ()
  (move-potato-1)

  (send *pr2* :angle-vector (send *ri* :state :potantio-vector))
  
  ;; 包丁を上に上げる
  (send *arrow* :newcoords (send (car (send *knife* :attention)) :copy-worldcoords))
  (send *arrow* :translate (float-vector 0 0 100) :world)
  (send *pr2* :rarm :inverse-kinematics
	*arrow*
	:move-target (car (send *knife* :attention))
	:rotation-axis t
	:debug-view t)
  (send *viewer* :draw-objects)
  (send *ri* :angle-vector (send *pr2* :angle-vector) 1000)
  (send *ri* :wait-interpolation)
  
  ;; set pose
  (send *arrow* :newcoords (make-coords :pos #f(700.191 2189.104 866.677) :rpy #f(-2.341 -0.222 -0.482)))
  (send *pr2* :rarm :inverse-kinematics
	*arrow*
	:rotation-axis t
	:debug-view t)
  (send *viewer* :draw-objects)
  (send *ri* :angle-vector (send *pr2* :angle-vector) 1000)
  (send *ri* :wait-interpolation)  

  ;; release knife
  (send *pr2* :rarm :end-coords :dissoc *knife*)
  (send *ri* :speak-jp "包丁を離します")
  (unix:sleep s-time)
  (send *ri* :stop-grasp :rarm :wait t)
  
  ;; grasp peeler
  (send *ri* :speak-jp "ピーラーを握らせて下さい")
  (unix:sleep s-time)
  (send *ri* :start-grasp :rarm :wait t :gain 100)

  (setq *peeler* (peeler))
  (send *peeler* :newcoords (send (send *pr2* :rarm :end-coords) :copy-worldcoords))
  (send *pr2* :rarm :end-coords :assoc *peeler*)

  (objects (list *kitchen* *pr2* *cutting-board* *potato* *peeler*))
  (send *irtviewer* :look-all
	(geo::make-bounding-box 
	 (flatten (send-all (send *pr2* :bodies) :vertices))))

  (warn "please run (peel-test) ~%")
  )

(defun peel-test ()
  (send *arrow* :newcoords (send (send *pr2* :rarm :end-coords) :copy-worldcoords))
  (send *arrow* :translate #f(0 0 200) :world)
  (send *pr2* :rarm :inverse-kinematics
	(send *arrow* :copy-worldcoords)
	:rotation-axis nil
	:debug-view t)
  (send *viewer* :draw-objects)
  (send *ri* :angle-vector (send *pr2* :angle-vector) 4000)
  (send *ri* :wait-interpolation)
    
  (send *arrow* :newcoords (send (send *pr2* :larm :end-coords) :copy-worldcoords))
  (send *arrow* :rotate (deg2rad 180) :z)
  (send *arrow* :translate (float-vector 0 0 (* 1 height)) :world)
  (send *arrow* :rotate (deg2rad 60) :y)
  (send *arrow* :translate (float-vector 0 100 100) :world)

  (send *pr2* :rarm :inverse-kinematics
	*arrow*
	:move-target (car (send *peeler* :attention))
	:rotation-axis t
	:debug-view t)
  (send *viewer* :draw-objects)
  (send *ri* :angle-vector (send *pr2* :angle-vector) 4000)
  (send *ri* :wait-interpolation)

  (send *arrow* :translate (float-vector 0 -100 -100) :world)
  (send *pr2* :rarm :inverse-kinematics
	*arrow*
	:move-target (car (send *peeler* :attention))
	:rotation-axis t
	:debug-view t)
  (send *viewer* :draw-objects)
  (send *ri* :angle-vector (send *pr2* :angle-vector) 4000)
  (send *ri* :wait-interpolation)

  ;; 皮剥き始める所
  (send *arrow* :translate (float-vector 0 0 (- (* -1 height) 20)) :world)
  (send *pr2* :rarm :inverse-kinematics
	*arrow*
	:move-target (car (send *peeler* :attention))
	:rotation-axis t
	:debug-view t)
  (send *viewer* :draw-objects)
  (send *ri* :angle-vector (send *pr2* :angle-vector) 4000)
  (send *ri* :wait-interpolation)

  ;; 剥き終わり
  (send *arrow* :rotate (deg2rad -30) :y)
  (send *arrow* :translate (float-vector (* (+ width 20) -1) 0 0) )
  (send *arrow* :rotate (deg2rad 30) :y)

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

  (warn "please run (put-potato)~%")
  )


(defun put-potato ()
  (send *pr2* :larm :end-coords :assoc *potato*)
  (setq *larm-peel-coords* (send (send *pr2* :larm :end-coords) :copy-worldcoords))

  ;; 上に上げる
  (send *arrow* :newcoords (send (send *pr2* :larm :end-coords) :copy-worldcoords))
  (send *arrow* :translate #f(0 0 150) :world)
  (send *pr2* :larm :inverse-kinematics
	(send *arrow* :copy-worldcoords)
	:rotation-axis t
	:debug-view t)
  (send *viewer* :draw-objects)
  (send *ri* :angle-vector (send *pr2* :angle-vector) 4000)
  (send *ri* :wait-interpolation)

  ;; 置く
  (send *arrow* :move-to (make-coords :pos (float-vector 500.0 2000.0 850.0) :rot #2f((1.0 0.0 0.0) (0.0 0.0 -1.0) (0.0 1.0 0.0))) :world)

  (send *pr2* :larm :inverse-kinematics
	(send *arrow* :copy-worldcoords)
	:move-target *cut-point-1*
	:rotation-axis t
	:debug-view t)
  (send *viewer* :draw-objects)
  (send *ri* :angle-vector (send *pr2* :angle-vector) 4000)
  (send *ri* :wait-interpolation)

  (setq *larm-put-coords* (send (send *pr2* :larm :end-coords) :copy-worldcoords))

  ;; release potato
  (send *pr2* :larm :end-coords :dissoc *potato*)
  (send *ri* :stop-grasp :rarm :wait t)


  (send *arrow* :newcoords (send *larm-put-coords* :copy-worldcoords))
  (send *arrow* :translate #f(0 0 80) :world)
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
  (send *arrow* :newcoords (send *potato* :copy-worldcoords))
  (send *arrow* :rotate (deg2rad -30) :z :world)
  (send *arrow* :rotate (deg2rad 30) :y)

  (send *pr2* :larm :inverse-kinematics
  	(send *arrow* :copy-worldcoords)
  	:rotation-axis t
  	:debug-view t)
  (send *viewer* :draw-objects)
  (send *ri* :angle-vector (send *pr2* :angle-vector) 4000)
  (send *ri* :wait-interpolation)

  (setq *larm-grasp-coords* (send (send *pr2* :larm :end-coords) :copy-worldcoords))
  (send *pr2* :larm :end-coords :assoc *potato*)
  (send *ri* :start-grasp :larm :wait t)
  
  (warn "please run (set-peel)~&")
  )

(defun set-peel ()
  ;; 上に上げる
  (send *arrow* :newcoords (send (send *pr2* :larm :end-coords) :copy-worldcoords))
  (send *arrow* :translate #f(0 0 100) :world)
  (send *pr2* :larm :inverse-kinematics
	(send *arrow* :copy-worldcoords)
	:rotation-axis t
	:debug-view t)
  (send *viewer* :draw-objects)
  (send *ri* :angle-vector (send *pr2* :angle-vector) 4000)
  (send *ri* :wait-interpolation)

  (send *pr2* :larm :inverse-kinematics
  	(send *larm-peel-coords* :copy-worldcoords)
  	:rotation-axis t
  	:debug-view t)
  (send *viewer* :draw-objects)
  (send *ri* :angle-vector (send *pr2* :angle-vector) 4000)
  (send *ri* :wait-interpolation)

  (warn "please run (peel-test2) or (next-set)~&")
  )

(defun peel-test2 ()
  (peel-test)
  (warn "please run (finish-pose2)~&")
  )

(defun finish-pose2 ()
  (finish-pose)
  (warn "please run (put-potato2)~&")  
  )

(defun put-potato2 ()
  (send *pr2* :larm :end-coords :assoc *potato*)
  
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
  (send *pr2* :larm :end-coords :dissoc *potato*)
  
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
  (send *arrow* :newcoords (send *larm-grasp-coords* :copy-worldcoords))
  (send *pr2* :larm :inverse-kinematics
  	(send *arrow* :copy-worldcoords)
  	:rotation-axis t
  	:debug-view t)
  (send *viewer* :draw-objects)
  (send *ri* :angle-vector (send *pr2* :angle-vector) 4000)
  (send *ri* :wait-interpolation)

  (send *pr2* :larm :end-coords :assoc *potato*)
  (send *ri* :start-grasp :larm :wait t)
  
  (warn "please run (set-peel)~&")  
  )

(defun finish ()
  (send *arrow* :newcoords (send (send *pr2* :rarm :end-coords) :copy-worldcoords))
  (send *arrow* :translate #f(0 0 200) :world)
  (send *pr2* :rarm :inverse-kinematics
	(send *arrow* :copy-worldcoords)
	:rotation-axis nil
	:debug-view t)
  (send *viewer* :draw-objects)
  (send *ri* :angle-vector (send *pr2* :angle-vector) 4000)
  (send *ri* :wait-interpolation)

  (send *ri* :stop-grasp :larm :wait t)
  (send *arrow* :newcoords (send *potato* :copy-worldcoords))
  (send *arrow* :translate #f(0 -100 100) :world)
  (send *pr2* :larm :inverse-kinematics (send *arrow* :copy-worldcoords))
  (send *viewer* :draw-objects)
  (send *ri* :angle-vector (send *pr2* :angle-vector) 4000)
  (send *ri* :wait-interpolation)

  (send *pr2* :reset-manip-pose)
  (send *pr2* :torso_lift_joint :joint-angle 325)
  (send *viewer* :draw-objects)
  (send *ri* :angle-vector (send *pr2* :angle-vector) 4000)
  (send *ri* :wait-interpolation)
  
  )


(defun next-set ()
  (peel-test2)
  (finish-pose2)
  (put-potato2)
  (next-grasp2)
  (set-peel)  
  )

(defun now-devel ()
  (set-potato :w width :l length :h height)
  ;; (set-potato)
  (grasp-potato)
  (set-knife-hor)
  (cut-test3)
  
  )


(defun now-test ()
  (set-potato :w width :l length :h height)
  ;; (set-potato)
  (grasp-potato)
  (set-knife-hor)
  (cut-test3)

  (change-peeler)
  (peel-test)
  (finish-pose)

  (put-potato)
  (next-grasp)
  (set-peel)
  )


(defun exec-all ()
  (set-potato :w width :l length :h height)
  (grasp-potato)
  (set-knife-hor)
  (cut-test3)

  (change-peeler)
  (peel-test)
  (finish-pose)

  (put-potato)
  (next-grasp)
  (set-peel)

  (dotimes (i 10)
    (next-set)
    )
  (peel-test2)
  (finish)
  )
