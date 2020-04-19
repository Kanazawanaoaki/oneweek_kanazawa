# PR2

PR2関連のeuslispのプログラムの書き方などのメモ。  

## Initialize
IRTだけなら
```
(load "package://pr2eus/pr2.l")   
(setq *pr2* (pr2))
(objects (list *pr2*))  
```
kinematics simulator等のros関連も使う場合
```
(load "package://pr2eus/pr2-interface.l")
(pr2-init)
(objects (list *pr2*))  
```

## PR2を動かす。
### 定義されているposeを使う。
reset-pose
```lisp
(send *pr2* :reset-pose)
;; (send *ri* :angle-vector (send *pr2* :angle-vector) 1000)
```
init-pose
```lisp
(send *pr2* :init-pose)
;; (send *ri* :angle-vector (send *pr2* :angle-vector) 1000)
```
reset-manip-pose
```lisp
(send *pr2* :reset-manip-pose)
;; (send *ri* :angle-vector (send *pr2* :angle-vector) 1000)
```

定義されているposeは
```
(send *pr2* :methods 'pose)
```
などで調べるのが良さそう。

### 関節角度を指定する。
angle-vector（全部の関節角度を指定）
```lisp
(send *pr2* :angle-vector #f(325.0 60.0 74.0 70.0 -120.0 20.0 -30.0 180.0 -60.0 74.0 -70.0 -120.0 -20.0 -30.0 180.0 0.0 0.0))
```
joint-angle（一つの関節の値を指定）
```lisp
(send *pr2* :torso_lift_joint :joint-angle 325)
```

### 逆運動学(IK)を解く。
目標の座標を指定する。
```lisp
(send *pr2* :rarm :inverse-kinematics
        (make-coords :pos #f(660 1550 710) :rpy #f(3.142 0 -1.571))
        :rotation-axis :t
        :debug-view t)
```
エンドエフェクターの移動を指定する。
```lisp
(send *pr2* :larm :move-end-pos #f(50 0 100) :world
	:debug-view t :look-at-target t)
```

### 移動する
定義されているspotに移動する
```lisp
(send *pr2* :move-to (send *room73b2* :spot "cook-spot") :world)

;; kinematics simulatorで利用する場合。多分もっと良い書き方ある。
(require :pr2-move "package://jsk_demo_common/euslisp/pr2-move.l")
(defun go-to-spot (&key (wait t) (spot-name "fridge-front-spot"))
  (let ((co (send *scene* :spot "/eng2/7f/room73B2-fridge-front")))
    (send co :translate (float-vector 0 0 0) :world)
    (if (send *ri* :simulation-modep)
        (setq co (send *room73b2* :spot spot-name)))
    (cond
     ((equal wait t)
      (send *ri* :move-to co)
      )
     (t
      (send *ri* :move-to-send co)
      ))
    t
    ))
(go-to-spot :wait t :spot-name "cook-spot")
```
指定した座標まで移動する。
```lisp
(setq *desk-spot* (make-coords :pos #f(3470 -1900 0) :rpy #f(-1.57 0 0)))
(send *pr2* :move-to *desk-spot* :world)

(send *ri* :move-to *desk-spot*)
```
移動する量を指定する。
```lisp
(send *ri* :go-pos 1 0 90) ;; x[m] y[m] 回転[°]
```

### 物体をつかむ
つかむ
```lisp
;;(send (send *pr2* :larm :end-coords :parent) :assoc *axis*)
(send (send *pr2* :larm :end-coords :parent) :assoc *kettle*)
(send *ri* :start-grasp :larm :wait t) ;; :start-graspは自動的にcollision判定をしてつかむらしい。
```
はなす
```lisp
;;(send (send *pr2* :larm :end-coords :parent) :dissoc *kettle*)
(send (send *pr2* :larm :end-coords :parent) :dissoc *axis*)
(send *ri* :stop-grasp :larm :wait t)
```

### Tips
arrow-objectで可視化すると便利。
```lisp
(load "models/arrow-object.l")
(setq *axis* (arrow))

(send *axis* :newcoords (send *kettle* :copy-worldcoords))
(send *axis* :transform (car (send *kettle* :handle)))

(send *pr2*　:larm　:inverse-kinematics                     
	    *axis*
	    :rotation-axis :t
	    :debug-view t)  
```

持っている道具の座標をmove-targetにしてIKを解く
```lisp
(send *pr2* :larm :inverse-kinematics
        (make-coords :pos #f(497.704 1550 930) :rpy #f( -3.14 0 0.7))
        :move-target *kettle*
	      :rotation-axis :t
        :debug-view t)
```

現在のエンドエフェクターの姿勢と同じ姿勢を指定してIKを解く。
```lisp
(setq *now-rpy* (car (send (send (send *pr2* :larm :end-coords) :worldcoords) :rpy-angle)))
(send *pr2* :larm :inverse-kinematics     
        (make-coords :pos #f(500 1500 1020) :rpy *now-rpy*)
        :rotation-axis :t                                            
        :debug-view t)
```
