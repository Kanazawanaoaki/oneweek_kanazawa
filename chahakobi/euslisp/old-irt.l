#!/usr/bin/env roseus

;; ロボットシステムの資料を参考に書いていく (detect_cans_in_fridge_201202/euslisp/main.lも？)

;; robot initialize
(load "package://pr2eus/pr2.l")   
(setq *pr2* (pr2)) 

;; set room73b2
(load "models/room73b2-scene.l")
(setq *room73b2* (room73b2))


;; IRT viewer
(objects (list *pr2* *room73b2*))

;; set kettle
(setq *kettle* (send *room73b2* :object "room73b2-kettle"))  
(if (send *kettle* :parent) (send (send *kettle* :parent) :dissoc *kettle*))
(send *kettle* :rotate (deg2rad -180) :z :world) 


;; set cup
(setq *cup* (send *room73b2* :object "room73b2-mug-cup"))
(if (send *cup* :parent) (send (send *cup* :parent) :dissoc *cup*))


(format t ";; please run (go-to-cook) , (exec-all) or (now-devel)~%")

;; キッチンまで行く
(defun go-to-cook ()
  (send *pr2* :move-to (send *room73b2* :spot "cook-spot") :world)
  (send *pr2* :torso_lift_joint :joint-angle 325)

  (send *irtviewer* :look-all
	(geo::make-bounding-box
	 (flatten (send-all (send *pr2* :bodies) :vertices))))
  
  (unix:sleep 1)
  (format t ";; please run (pick-up-kettle)~%"))

(defun pick-up-kettle ()
  ;; やかんを持つ
  (setq *kettle-tar* (car (send *kettle* :handle)))
  (send *kettle-tar* :rotate (deg2rad -180) :z :world)
  
  (send *pr2* :head :look-at (send *kettle* :worldpos))
  (unix:sleep 1)
  
  (send *pr2* :larm :inverse-kinematics                                              
	*kettle-tar*
	:rotation-axis :z
	:debug-view t)
  (unix:sleep 1)
  
  (send *pr2* :larm :end-coords :assoc *kettle*)
  (send *pr2* :larm :move-end-pos #f(50 0 100) :world
	:debug-view t :look-at-target t)
  (unix:sleep 1)
  (send *pr2* :larm :move-end-pos #f(0 0 100) :world
	:debug-view t :look-at-target t)

  (setq *move-pose* (send *pr2* :angle-vector))
  (unix:sleep 1)
  (format t ";; please run (go-to-sink)~%"))

(defun go-to-sink ()
  ;; シンクまで移動する
  (send *pr2* :move-to (send *room73b2* :spot "/eng2/7f/room73B2-sink-front")  :world)
  (send *pr2* :move-to (make-coords :pos #f(300 -150 0)))
  (format t ";; please run (pour-water)~%"))

(defun pour-water ()
  ;; やかんに水を入れる
  (send *pr2* :larm :inverse-kinematics
	(make-coords :pos #f(370 2580 900) :rpy #f(-3.141 -0.647 -1.571))
	:rotation-axis :t
	:debug-view t)
  (send *pr2* :rarm :inverse-kinematics
	(make-coords :pos #f(200 2580 950) :rpy #f(3.141 -1.571 -1.571))
	:rotation-axis :z
	:debug-view t)
  (unix:sleep 1)

  (send *pr2* :rarm :move-end-pos #f(0 0 50) :world
	:debug-view t :look-at-target t)

  (unix:sleep 2) ;;本来は中身をみて一定の量になったら終了する。時間指定も有り。

  (send *pr2* :rarm :move-end-pos #f(0 0 -50) :world
	:debug-view t :look-at-target t)

  (send *pr2* :angle-vector *move-pose*)
  (format t ";; please run (go-to-cook2)~%")
  )

;; コンロの前に行く
(defun go-to-cook2 ()
  (send *pr2* :move-to (send *room73b2* :spot "cook-spot") :world)
  (send *pr2* :torso_lift_joint :joint-angle 325)
  (unix:sleep 1)
  (format t ";; please run (put-kettle)~%"))


;; やかんを置く
(defun put-kettle ()
  (send *pr2* :larm :inverse-kinematics
        (make-coords :pos #f(500 1500 1020) :rpy #f(3.142 -0.647 -1.571))
        :rotation-axis :t
        :debug-view t)
  (send *pr2* :larm :end-coords :dissoc *kettle*)

  (send *pr2* :larm :move-end-pos #f(40 0 0) :world
	:debug-view t :look-at-target t)

  (send *pr2* :angle-vector *move-pose*)
  (format t ";; please run (put-on-stove)~%"))

;; コンロをつける
(defun put-on-stove ()
  (send *pr2* :rarm :inverse-kinematics
        (make-coords :pos #f(660 1550 710) :rpy #f(3.142 0 -1.571))
        :rotation-axis :t
        :debug-view t)

  (send *pr2* :angle-vector *move-pose*)
  (format t ";; please run (prepare-tea)~%"))


;; お茶orコーヒーorカップラーメンを用意する
(defun prepare-tea ()
  ;; お茶のパックを引き出しから出して、セットする

  (format t ";; please run (wait-boil)")
  )

;; お湯が湧くのを待つ（音認識）
(defun wait-boil ()
  (unix:sleep 2) ;; 本当は音がなったらとかにする。
  (format t ";; please run (turn-off-stove)~%")
  )

;; コンロを消す
(defun turn-off-stove ()
  (send *pr2* :rarm :inverse-kinematics
        (make-coords :pos #f(660 1550 710) :rpy #f(3.142 0 -1.571))
        :rotation-axis :t
        :debug-view t)

  (send *pr2* :angle-vector *move-pose*)
  (format t ";; please run (pick-up-kettle2)~%")
  )

;; やかんを持つ
(defun pick-up-kettle2 ()
  (setq *kettle-tar* (car (send *kettle* :handle)))
  (send *kettle-tar* :rotate (deg2rad -180) :z :world)
  
  (send *pr2* :head :look-at (send *kettle* :worldpos))
  (unix:sleep 1)
  
  (send *pr2* :larm :inverse-kinematics                                              
	*kettle-tar*
	:rotation-axis :z
	:debug-view t)
  (unix:sleep 1)
  
  (send *pr2* :larm :end-coords :assoc *kettle*)
  (send *pr2* :larm :move-end-pos #f(0 70 50) :world
  	:debug-view t :look-at-target t)
  (unix:sleep 1)
  (format t ";; please run (pour-hot-water)~%"))

;; コップにお湯を入れる
(defun pour-hot-water ()
  (send *pr2* :larm :inverse-kinematics
        (make-coords :pos #f(497.704 1550 930) :rpy #f( -3.14 0 0.7))
        :move-target *kettle*
	:rotation-axis :t
        :debug-view t)
  (unix:sleep 2) ;;本当は認識して注げたかを確認する。

  (send *pr2* :larm :inverse-kinematics                                          
        (make-coords :pos #f(500.164 1569.706 875.318) :rpy #f( -3.141 0.001 0))
        :move-target *kettle*
	:rotation-axis :t                                           
        :debug-view t)  
  (format t ";; please run (put-kettle2)~%"))

;; やかんを戻す
(defun put-kettle2 ()
  (send *pr2* :larm :inverse-kinematics                                          
        (make-coords :pos #f(500 1500 1020) :rpy #f(-3.141 0.506 1.571))
        :rotation-axis :t                                            
        :debug-view t)
  (send *pr2* :larm :end-coords :dissoc *kettle*)

  (send *pr2* :larm :move-end-pos #f(40 0 0) :world
	:debug-view t :look-at-target t)

  (send *pr2* :angle-vector *move-pose*)
  (format t ";; please run (pick-up-cup)~%"))

;; コップをつかむ
(defun pick-up-cup ()
  (send *pr2* :reset-pose)
  (setq *cup-tar* (car (send *cup* :handle)))
  (send *pr2* :head :look-at (send *cup* :worldpos))
  
  (send *pr2* :rarm :inverse-kinematics                                              
	*cup-tar*
	:rotation-axis :z
	:debug-view t)
  (unix:sleep 1)
  
  (send *pr2* :rarm :end-coords :assoc *cup*)
  
  (send *pr2* :rarm :move-end-pos #f(100 -100 100) :world
  	:debug-view t :look-at-target t)
  (unix:sleep 1)
  (send *pr2* :rarm :move-end-pos #f(100 -100 100) :world
  	:debug-view t :look-at-target t)

  (unix:sleep 1)
  (format t ";; please run (go-to-desk)~%"))

;; 机まで持っていく
(defun go-to-desk ()
  (setq *desk-spot* (make-coords :pos #f(3470 -1900 0) :rpy #f(-1.57 0 0)))
  (send *pr2* :move-to *desk-spot* :world)
  
  (send *pr2* :rarm :inverse-kinematics
	(make-coords :pos #f(3470 -2500 700) :rpy #f(1.571 0 0))
	:move-target *cup*
	:rotation-axis :t
	:debug-view t)
  
  (send *pr2* :rarm :end-coords :dissoc *cup*)
  (send *pr2* :rarm :move-end-pos #f(-50 0 0) :world                    
	:debug-view t :look-at-target t)
  (send *pr2* :reset-pose)

  (format t ";; please enjoy tea!~%"))                                            


(defun exec-all ()
  (go-to-cook)
  (pick-up-kettle)
  (go-to-sink)
  (pour-water)
  (go-to-cook2)
  (put-kettle)
  (put-on-stove)
  (prepare-tea)
  (wait-boil)
  (turn-off-stove)
  (pick-up-kettle2)
  (pour-hot-water)
  (put-kettle2)
  (pick-up-cup)
  (go-to-desk)
  )

(defun now-devel ()
  (go-to-cook)
  (pick-up-kettle)
  (go-to-sink)
  (pour-water)
  (go-to-cook2)
  (put-kettle)
  (put-on-stove)
  )
  
