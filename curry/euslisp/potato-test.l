#!/usr/bin/env roseus

;; robot initialize
(load "package://pr2eus/pr2.l")   
(setq *robot* (pr2))
(send *robot* :reset-manip-pose)

;; set kitchen
(load "models/room73b2-kitchen-object.l")
(setq *kitchen* (room73b2-kitchen))
(send *kitchen* :locate #f(700 -200 0))
(send *kitchen* :rotate (deg2rad 180) :z :world)

;; ;; set frige
;; (load "models/room73b2-toshiba-clacio-refrigerator-object.l")
;; (setq *frige* (room73b2-toshiba-clacio-refrigerator))
;; (send *frige* :locate #f(-325 -1675 0))
;; (send *frige* :rotate (deg2rad 90) :z :world)

;; ;; set knife
;; (load "models/knife-object.l")
;; (setq *knife* (knife))
;; (send *knife* :locate #f(550.0 -200.0 850.0))

;; set peeler
(load "model/peeler.l")
(setq *peeler* (peeler))
(send *peeler* :locate #f(450.0 -250.0 830.0))

;; set まな板
(load "model/cutting-board.l")
(setq *cutting-board* (cutting-board))
(send *cutting-board* :locate #f(550 0 825))

;; ;; set 調理鍋
;; (load "model/cooking-pot.l")
;; (setq *pot* (cooking-pot))
;; (send *pot* :locate #f(680 500 830))

;; ;; set onion
;; (load "model/onion.l")
;; (setq *onion* (onion))
;; (send *onion* :locate #f(850 200 845))

;; ;; set tomato
;; (load "model/tomato.l")
;; (setq *tomato* (tomato))
;; (send *tomato* :locate #f(850 100 845))

;; ;; set carrot
;; (load "model/carrot.l")
;; (setq *carrot* (carrot))
;; (send *carrot* :locate #f(850 0 845))

;; set potato
(load "model/potato.l")
(setq *potato* (potato))
(send *potato* :locate #f(500 0 850))

;; (setq *env-list* (list *kitchen* *peeler* *cutting-board* *potato*))

(load "models/arrow-object.l")
(setq *arrow* (arrow))
(send *arrow* :newcoords (send *potato* :copy-worldcoords))
(send *arrow* :rotate (deg2rad 90) :y)

;; set spots
(setq *sink-spot* (make-coords :pos #f(0 -600 0)))
(setq *kitchen-spot* (make-coords :pos #f(0 0 0)))

;; set points
(setq *water-point* (make-coords :pos #f(670 -600 830)))
(setq *faucet-point* (make-coords :pos #f(810 -600 950)))

;; set poses
(setq *carry-pose* #f(300.0 12.2215 -15.327 61.4956 -98.4927 -291.239 -114.592 85.133 -75.0 50.0 -110.0 -110.0 20.0 -10.0 -10.0 0.0 50.0) )


;; (objects (append *env-list* (list *robot* *arrow*))) 

;; (objects (list *kitchen* *peeler* *cutting-board* *potato* *arrow* *robot*))
(objects (list *kitchen* *peeler* *cutting-board* *potato* *robot*))

(format t ";; please run (grasp-potato) or (now-devel)~%"))

(defun grasp-potato ()
  (send *arrow* :newcoords (send *potato* :copy-worldcoords))
  (send *arrow* :rotate (deg2rad 90) :y)
  (send *arrow* :translate #f(0 0 100) :world)

  (send *robot* :larm :inverse-kinematics
	*arrow*
	:rotation-axis :t
	:debug-view t)
  (unix:sleep 1)

  (send *arrow* :translate #f(0 0 -100) :world)
  (send *robot* :larm :inverse-kinematics
	*arrow*
	:rotation-axis :t
	:debug-view t)
  (unix:sleep 1)

  (send (send *robot* :larm :end-coords) :assoc *potato*)

  (send *arrow* :translate #f(0 0 100) :world)
  (send *robot* :larm :inverse-kinematics
	*arrow*
	:rotation-axis :t
	:debug-view t)
  (unix:sleep 1)

  ;; (send *arrow* :translate #f(-100 0 100) :world)
  ;; (send *arrow* :translate #f(0 0 100) :world)
  ;; (send *robot* :larm :inverse-kinematics
  ;; 	*arrow*
  ;; 	:rotation-axis :t
  ;; 	:debug-view t)

  (send *robot* :angle-vector *carry-pose*)

  (format t ";; please run (go-to-sink)~%"))
  )

(defun go-to-sink ()
  (send *robot* :move-to *sink-spot* :world)
  (format t ";; please run (wash-potato)~%"))
  )

(defun wash-potato ()
  (send *arrow* :newcoords (send *water-point* :copy-worldcoords))
  (send *arrow* :rotate (deg2rad -90) :y)
  
  (send *robot* :larm :inverse-kinematics
	*arrow*
	:move-target *potato*
	:rotation-axis t
	:debug-view t)

  (unix:sleep 1)

  (send *arrow* :newcoords (send *faucet-point* :copy-worldcoords))
  (send *robot* :rarm :inverse-kinematics
	*arrow*
	:rotation-axis nil
	:debug-view t)
  (unix:sleep 1)
  
  (send *robot* :rarm :move-end-pos #f(0 0 50) :world
  	:debug-view t :look-at-target t)

  (unix:sleep 2) ;;本来は個々で洗う動作を行う。

  (send *robot* :rarm :move-end-pos #f(0 0 -50) :world
  	:debug-view t :look-at-target t)

  (send *robot* :angle-vector *carry-pose*)
  (format t ";; please run (go-to-kitchen)~%"))
  )

(defun go-to-kitchen ()
  (send *robot* :move-to *kitchen-spot* :world)
  (format t ";; please run (pick-peeler)~%"))
  )
  
(defun pick-peeler ()

  ;; 本当は持ち替えが必要？
  (send *arrow* :newcoords (send (car (send *peeler* :handle)) :copy-worldcoords))
  (send *robot* :rarm :inverse-kinematics
	*arrow*
	:rotation-axis t
	:debug-view t)

  (send (send *robot* :rarm :end-coords) :assoc *peeler*)

  (send *robot* :reset-manip-pose)
  
  (format t ";; please run (set-peel)~%"))  
  )

(defun set-peel ()
  (send *arrow* :newcoords (make-coords :pos #f(500 50 1050) :rpy #f(-1.57 0 0)))
  
  (send *arrow* :rotate (deg2rad -30) :z)
  (send *arrow* :rotate (deg2rad -50) :y)

  (send *robot* :larm :inverse-kinematics
	*arrow*
	:rotation-axis t
	:debug-view t)

  (format t ";; please run (peel-move-1)~%"))  
  )


(defun peel-move-1 ()
  (send *arrow* :newcoords (send *potato* :copy-worldcoords))
  (send *arrow* :translate #f(50 0 -20)) ;; ここを認識から大きさに合わせてとかやるのが良い。

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
  
(defun now-devel ()
  (grasp-potato)
  (go-to-sink)
  (wash-potato)
  (go-to-kitchen)
  (pick-peeler)
  (set-peel)
  )
