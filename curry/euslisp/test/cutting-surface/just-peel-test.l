(load "../../model/my-room73b2-scene.l")
(setq *room* (room73b2))

(load "package://pr2eus/pr2-interface.l")
(pr2-init)

;; kitchen
(load "models/room73b2-kitchen-object.l")
(setq *kitchen* (room73b2-kitchen))
(send *kitchen* :transform (make-coords :pos (float-vector 305.0 2175.0 20.0) :rot #2f((1.0 2.449294e-16 0.0) (-2.449294e-16 1.0 0.0) (0.0 0.0 1.0))))

 ;; set まな板
(load "../../model/cutting-board.l")
(setq *cutting-board* (cutting-board))
(send *cutting-board* :transform (make-coords :pos (float-vector 500.0 2000.0 840.0) :rot #2f((1.0 2.449294e-16 0.0) (-2.449294e-16 1.0 0.0) (0.0 0.0 1.0))))

;; set objects
(load "../../model/potato-test-model.l")
(load "../../model/peeler.l")
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

(objects (list *kitchen* *pr2* *cutting-board*))
(send *irtviewer* :look-all
      (geo::make-bounding-box 
       (flatten (send-all (send *pr2* :bodies) :vertices))))

;; def global values
(setq s-time 4)

(setq width 90)
(setq length 60)
(setq height 30)

(warn "please run (set-potato :w 90 :l 60 :h 60) or (now-devel)~%")

(defun set-potato (&rest args &key (w 90) (l 60) (h 60) &allow-other-keys)

  (setq width w)
  (setq length l)
  (setq height h)
  
  (setq *potato* (potato :w w :l l :h h))
  (send *potato* :transform (make-coords :pos (float-vector 500.0 2000.0 (+ 850.0 (/ h 2))) :rot #2f((1.194340e-15 -1.0 0.0) (1.0 1.194340e-15 0.0) (0.0 0.0 1.0))))
  (send *potato* :peel)
  
  (objects (list *kitchen* *pr2* *cutting-board* *potato*))
  (send *irtviewer* :look-all
	(geo::make-bounding-box 
	 (flatten (send-all (send *pr2* :bodies) :vertices))))

  (warn "please run (set-peeler) ~%")
  )

(defun set-peeler ()
  ;; set pose
  (send *pr2* :reset-manip-pose)
  (send *pr2* :torso_lift_joint :joint-angle 325)
  (send *viewer* :draw-objects)
  (send *ri* :angle-vector (send *pr2* :angle-vector) 4000)
  (send *ri* :wait-interpolation)

  ;; grasp peeler
  (send *ri* :stop-grasp :rarm :wait t)
  (send *ri* :speak-jp "ピーラーを握らせて下さい")
  (unix:sleep s-time)
  ;; (send *ri* :start-grasp :rarm :wait t)
  (send *ri* :start-grasp :rarm :wait t :gain 100)
  
  (setq *peeler* (peeler))
  (send *peeler* :newcoords (send (send *pr2* :rarm :end-coords) :copy-worldcoords))
  (send *pr2* :rarm :end-coords :assoc *peeler*)

  (objects (list *kitchen* *pr2* *cutting-board* *potato* *peeler*))
  (send *irtviewer* :look-all
	(geo::make-bounding-box 
	 (flatten (send-all (send *pr2* :bodies) :vertices))))

  (warn "please run (set-larm) ~%")
  )

(defun set-peeler-hor ()
  ;; set pose
  (send *pr2* :reset-manip-pose)
  (send *pr2* :torso_lift_joint :joint-angle 325)
  (send *viewer* :draw-objects)
  (send *ri* :angle-vector (send *pr2* :angle-vector) 4000)
  (send *ri* :wait-interpolation)

  ;; grasp peeler
  (send *ri* :stop-grasp :rarm :wait t)
  (send *ri* :speak-jp "ピーラーを握らせて下さい")
  (unix:sleep s-time)
  ;; (send *ri* :start-grasp :rarm :wait t)
  (send *ri* :start-grasp :rarm :wait t :gain 100)
  
  (setq *peeler* (peeler))
  (send *peeler* :newcoords (send (send *pr2* :rarm :end-coords) :copy-worldcoords))
  (send *peeler* :rotate (deg2rad 90) :x)
  (send *pr2* :rarm :end-coords :assoc *peeler*)

  (objects (list *kitchen* *pr2* *cutting-board* *potato* *peeler*))
  (send *irtviewer* :look-all
	(geo::make-bounding-box 
	 (flatten (send-all (send *pr2* :bodies) :vertices))))

  (warn "please run (set-larm) ~%")
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
     
  ;; (send *arrow* :newcoords (send *cut-point-1* :copy-worldcoords))
  (warn "please run  (set-knife-hor) ~%")
  )

;; (defun set-larm ()
;;   (if (not (boundp '*peeler*))
;;       (progn
;; 	(setq *peeler* (peeler))
;; 	(send *peeler* :newcoords (send (send *pr2* :rarm :end-coords) :copy-worldcoords))
;; 	(send *pr2* :rarm :end-coords :assoc *peeler*)))

;;   (send *arrow* :newcoords (send (send *pr2* :larm :end-coords) :copy-worldcoords))
;;   ;; (send *arrow* :translate #f(0 0 200) :world)

;;   (send *arrow* :translate #f(0 0 250) :world)
;;   (send *pr2* :larm :inverse-kinematics
;; 	(send *arrow* :copy-worldcoords)
;; 	:rotation-axis nil
;; 	:debug-view t)
;;   (send *viewer* :draw-objects)
;;   (send *ri* :angle-vector (send *pr2* :angle-vector) 4000)
;;   (send *ri* :wait-interpolation)
  
  
;;   (send *arrow* :newcoords (send *potato* :copy-worldcoords))
;;   (send *arrow* :rotate (deg2rad 20) :y)

;;   (objects (list *kitchen* *pr2* *cutting-board* *potato* *peeler* *arrow*))
;;   (send *irtviewer* :look-all
;; 	(geo::make-bounding-box 
;; 	 (flatten (send-all (send *pr2* :bodies) :vertices))))

;;   (send *ri* :stop-grasp :larm :wait t)
;;   (send *arrow* :translate #f(0 -100 100) :world)
;;   ;; (send *arrow* :translate (float-vector (/ width -2) 0 (/ height 2)) :world)
;;   ;; (send *arrow* :translate (float-vector 0 (/ width -2) 0) :world)

;;   (send *arrow* :translate (float-vector 0 (/ width -2) -20) :world)
  
;;   (send *pr2* :larm :inverse-kinematics (send *arrow* :copy-worldcoords))
;;   (send *viewer* :draw-objects)
;;   (send *ri* :angle-vector (send *pr2* :angle-vector) 4000)
;;   (send *ri* :wait-interpolation)

;;   (send *arrow* :translate #f(0 100 -100) :world)
;;   (send *pr2* :larm :inverse-kinematics (send *arrow* :copy-worldcoords))
;;   (send *viewer* :draw-objects)
;;   (send *ri* :angle-vector (send *pr2* :angle-vector) 4000)
;;   (send *ri* :wait-interpolation)
;;   (send *ri* :start-grasp :larm :wait t)

;;   (warn "please run (peel-test1) or (peel-test2) ~%")  
;;   )

;; (defun set-larm-s ()
;;   (if (not (boundp '*peeler*))
;;       (progn
;; 	(setq *peeler* (peeler))
;; 	(send *peeler* :newcoords (send (send *pr2* :rarm :end-coords) :copy-worldcoords))
;; 	(send *pr2* :rarm :end-coords :assoc *peeler*)))

;;   (send *arrow* :newcoords (send (send *pr2* :larm :end-coords) :copy-worldcoords))
;;   (send *arrow* :translate #f(0 0 200) :world)
;;   (send *pr2* :larm :inverse-kinematics
;; 	(send *arrow* :copy-worldcoords)
;; 	:rotation-axis nil
;; 	:debug-view t)
;;   (send *viewer* :draw-objects)
;;   (send *ri* :angle-vector (send *pr2* :angle-vector) 4000)
;;   (send *ri* :wait-interpolation)
  
  
;;   (send *arrow* :newcoords (send *potato* :copy-worldcoords))
;;   (send *arrow* :rotate (deg2rad 20) :y)

;;   (objects (list *kitchen* *pr2* *cutting-board* *potato* *peeler* *arrow*))
;;   (send *irtviewer* :look-all
;; 	(geo::make-bounding-box 
;; 	 (flatten (send-all (send *pr2* :bodies) :vertices))))

;;   (send *ri* :stop-grasp :larm :wait t)
;;   (send *arrow* :translate #f(0 -100 100) :world)
;;   ;; (send *arrow* :translate (float-vector (/ width -2) 0 (/ height 2)) :world)
;;   (send *arrow* :translate (float-vector 0 (/ width -2) 0) :world)
  
;;   (send *pr2* :larm :inverse-kinematics (send *arrow* :copy-worldcoords))
;;   (send *viewer* :draw-objects)
;;   (send *ri* :angle-vector (send *pr2* :angle-vector) 4000)
;;   (send *ri* :wait-interpolation)

;;   (send *arrow* :translate #f(0 100 -100) :world)
;;   (send *pr2* :larm :inverse-kinematics (send *arrow* :copy-worldcoords))
;;   (send *viewer* :draw-objects)
;;   (send *ri* :angle-vector (send *pr2* :angle-vector) 4000)
;;   (send *ri* :wait-interpolation)
;;   ;; (send *ri* :start-grasp :larm :wait t)
;;   (send *ri* :start-grasp :rarm :wait t :gain 100)

;;   (warn "please run (peel-test1) or (peel-test2) ~%")  
;;   )

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


(defun peel-test1 ()
  (if (not (boundp '*potato*))
      (set-potato :w 90 :l 60 :h 60))

  (send *arrow* :newcoords (send (send *pr2* :rarm :end-coords) :copy-worldcoords))
  (send *arrow* :translate #f(0 0 200) :world)
  (send *pr2* :rarm :inverse-kinematics
	(send *arrow* :copy-worldcoords)
	:rotation-axis nil
	:debug-view t)
  (send *viewer* :draw-objects)
  (send *ri* :angle-vector (send *pr2* :angle-vector) 4000)
  (send *ri* :wait-interpolation)

  (send *arrow* :translate #f(-150 0 0) :world)
  (send *pr2* :rarm :inverse-kinematics
	(send *arrow* :copy-worldcoords)
	:rotation-axis nil
	:debug-view t)
  (send *viewer* :draw-objects)
  (send *ri* :angle-vector (send *pr2* :angle-vector) 4000)
  (send *ri* :wait-interpolation)

  
  (send *arrow* :newcoords (send *potato* :copy-worldcoords))
  (send *arrow* :rotate (deg2rad 180) :z :world)
  ;; (send *arrow* :translate (float-vector (/ width 2) 0 (* height 1)))

  (send *arrow* :translate (float-vector 0 0 (* height 1)) :world)
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
  (send p1 :set-color :moccasin)
  (send *viewer* :draw-objects)
  (send *ri* :angle-vector (send *pr2* :angle-vector) 4000)
  (send *ri* :wait-interpolation)
  
  (warn "you can retry (peel-test1) , (peel-test2) or you want to finish please run (finish) ~%")
  )

(defun peel-test2 ()
  (if (not (boundp '*potato*))
      (set-potato :w 90 :l 60 :h 60))

  (send *arrow* :newcoords (send *potato* :copy-worldcoords))
  (send *arrow* :rotate (deg2rad 180) :z :world)
  (send *arrow* :translate (float-vector (/ width 2) 0 (* height 1)))
  
  (send *pr2* :rarm :inverse-kinematics
	*arrow*
	:move-target (car (send *peeler* :attention))
	:rotation-axis t
	:debug-view t)
  (send *viewer* :draw-objects)
  (send *ri* :angle-vector (send *pr2* :angle-vector) 4000)
  (send *ri* :wait-interpolation)

  ;; 皮剥き始める所
  (send *arrow* :translate (float-vector 0 0 (+ (* -1 height) 10)))
  (send *pr2* :rarm :inverse-kinematics
	*arrow*
	:move-target (car (send *peeler* :attention))
	:rotation-axis t
	:debug-view t)
  (send *viewer* :draw-objects)
  (send *ri* :angle-vector (send *pr2* :angle-vector) 4000)
  (send *ri* :wait-interpolation)

  ;; 剥き終わり
  (setq interval 10)
  (dotimes (i (+ (round (/ width interval)) 1))
    (send *arrow* :translate (float-vector (* interval -1) 0 0))
    (send *pr2* :rarm :inverse-kinematics
	  *arrow*
	  :move-target (car (send *peeler* :attention))
	  :rotation-axis t
	  :debug-view t)
    (send *viewer* :draw-objects)
    (send *ri* :angle-vector (send *pr2* :angle-vector) 1000)
    (send *ri* :wait-interpolation)
    )

  (send p1 :set-color :moccasin)
  (send *viewer* :draw-objects)  
  
  (warn "you can retry (peel-test1) , (peel-test2) or you want to finish please run (finish) ~%")
  )


(defun peel-test3 ()
  (if (not (boundp '*potato*))
      (set-potato :w 90 :l 60 :h 60))

  (send *arrow* :newcoords (send (send *pr2* :rarm :end-coords) :copy-worldcoords))
  (send *arrow* :translate #f(0 0 200) :world)
  (send *pr2* :rarm :inverse-kinematics
	(send *arrow* :copy-worldcoords)
	:rotation-axis nil
	:debug-view t)
  (send *viewer* :draw-objects)
  (send *ri* :angle-vector (send *pr2* :angle-vector) 4000)
  (send *ri* :wait-interpolation)

  ;; (send *arrow* :translate #f(-150 0 0) :world)
  ;; (send *pr2* :rarm :inverse-kinematics
  ;; 	(send *arrow* :copy-worldcoords)
  ;; 	:rotation-axis nil
  ;; 	:debug-view t)
  ;; (send *viewer* :draw-objects)
  ;; (send *ri* :angle-vector (send *pr2* :angle-vector) 4000)
  ;; (send *ri* :wait-interpolation)

  (send *arrow* :newcoords (send (send *pr2* :larm :end-coords) :copy-worldcoords))
  (send *arrow* :rotate (deg2rad 180) :z)
  (send *arrow* :translate (float-vector 0 0 (* 1 height)) :world)
  ;; (send *arrow* :rotate (deg2rad 20) :y)
  (send *arrow* :rotate (deg2rad 40) :y)
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
  ;; (send *arrow* :translate (float-vector 0 0 (* -1 height)) :world)

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
  (send *arrow* :translate (float-vector 0 (* (+ width 20) 1) 0) :world)
  (send *pr2* :rarm :inverse-kinematics
	*arrow*
	:move-target (car (send *peeler* :attention))
	:rotation-axis t
	:debug-view t)
  (send p1 :set-color :moccasin)
  (send *viewer* :draw-objects)
  (send *ri* :angle-vector (send *pr2* :angle-vector) 4000)
  (send *ri* :wait-interpolation)
  
  (warn "you can retry (peel-test1) , (peel-test2) or you want to finish please run (finish) ~%")
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

(defun now-devel ()
  (setq s-time 0)

  (set-potato :w 90 :l 60 :h 60)  
  (set-peeler)
  (set-larm)
  )

(defun set-peel ()
  (set-potato :w 90 :l 60 :h 60)  
  (set-peeler)
  (set-larm)
  )

(defun exec-peel ()
  (set-potato :w 90 :l 60 :h 60)  
  (set-peeler)
  (set-larm)
  (peel-test1)
  )


(defun now-test ()
  (set-potato :w 90 :l 60 :h 60)  
  (set-larm)
  )



(defun test1 ()
  (unix:sleep 3)
  
  (set-potato :w 90 :l 60 :h 60)  
  (set-larm)

  (peel-test1)  
  )

(defun test2 ()
  (unix:sleep 3)
  
  (set-potato :w 90 :l 60 :h 60)  
  (set-larm)

  (peel-test2)  
  )

(defun test3 ()
  (unix:sleep 3)
  
  (set-potato :w 90 :l 60 :h 60)  
  (set-larm)

  (peel-test3)  
  )


(defun only-test ()
  (unix:sleep 3)
  
  (set-potato :w 90 :l 60 :h 60)  

  (peel-test1)  
  )

(defun strong-test ()
  (unix:sleep 3)
  
  (set-potato :w 90 :l 60 :h 60)  
  (set-larm-s)

  (peel-test3)  
  )

(defun hor-test ()
  (set-potato :w 90 :l 60 :h 60)  
  (set-peeler-hor)
  ;; (set-larm)
  ;; (peel-test1)
  (grasp-potato)
  (peel-test)
  )
