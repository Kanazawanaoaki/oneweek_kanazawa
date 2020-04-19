;; ロボットシステムの部屋のやつを実装

;;初期配置
(load "models/room73b2-scene.l") 
(load "models/h7-robot.l")
(setq *room* (room73b2))
(setq *robot* (h7)) 
(objects (list *robot* *room*))

;;初期姿勢
(send *robot* :reset-pose)

;;キッチンに移動。
(send *robot* :move-to (send *room* :spot "cook-spot") :world)
(send *robot* :locate #f(0 0 550))

;;画角調整
(send *irtviewer* :look-all
      (geo::make-bounding-box 
       (flatten (send-all (send *robot* :bodies) :vertices))))

;;ケトル
(setq *kettle* (send *room* :object "room73b2-kettle"))
(if (send *kettle* :parent) (send (send *kettle* :parent) :dissoc *kettle*))
(send *robot* :head :look-at (send *kettle* :worldpos))

;;ケトルを把持　※(send (car (send *kettle* :handle)) :draw-on :flush t)
(send *robot* :larm :inverse-kinematics
      (car (send *kettle* :handle))
      :link-list (send *robot* :link-list (send *robot* :larm :end-coords :parent))
      :move-target (send *robot* :larm :end-coords)
      :rotation-axis :z
      :debug-view t)

;;ロボットの手先と対象物体の座標系を転結
(send *robot* :larm :end-coords :assoc *kettle*)

;;持ち上げる
(send *robot* :larm :move-end-pos #f(-50 0 50) :world
      :debug-view t :look-at-target t)
