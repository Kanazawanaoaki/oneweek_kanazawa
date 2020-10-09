(defun init ()
  (if (not (boundp '*room*))
      (progn
        (load "../../model/my-room73b2-scene.l")
        (setq *room* (room73b2))
        ))
    
  (if (not (boundp '*kitchen*))
      (progn 
        (load "models/room73b2-kitchen-object.l")
        (setq *kitchen* (room73b2-kitchen))
        (send *kitchen* :transform (make-coords :pos (float-vector 305.0 2175.0 20.0) :rot #2f((1.0 0.0 0.0) (0.0 1.0 0.0) (0.0 0.0 1.0))))
        ))

  (if (not (boundp '*pr2*))
      (progn
        (load "package://pr2eus/pr2-interface.l")
        (pr2-init)
        ))

  ;; set まな板
  (load "../../model/cutting-board.l")
  (setq *cutting-board* (cutting-board))
  (send *cutting-board* :transform (make-coords :pos (float-vector 500.0 2000.0 840.0) :rot #2f((1.0 0.0 0.0) (0.0 1.0 0.0) (0.0 0.0 1.0))))

  ;; set objects
  (load "../../model/peeler.l")
  (load "../../model/potato-peeler.l")
  (load "../../model/knife-new-attention.l")
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
  (setq s-time 3)
  
  (setq adj 0)

  ;; set potato
  (load "../../model/potato-new-type.l")

  (setq width 90)
  (setq length 60)
  (setq height 60)
  )

(init)


(setq *knife* (knife))
(send *knife* :transform (make-coords :pos (float-vector 600.0 2400.0 900.0) :rot #2f((1.0 0.0 0.0) (0.0 1.0 0.0) (0.0 0.0 1.0))))
(send *knife* :rotate (deg2rad 180) :z :world)
(send *knife* :rotate (deg2rad -90) :x :world)

(load "../../model/peeler.l")
(setq *peeler* (peeler))
(send *peeler* :transform (make-coords :pos (float-vector 600.0 2300.0 900.0) :rot #2f((1.0 0.0 0.0) (0.0 1.0 0.0) (0.0 0.0 1.0))))
(send *peeler* :rotate (deg2rad 180) :z :world)
(send *peeler* :rotate (deg2rad -90) :x :world)

(load "../../model/potato-peeler.l")
(setq *potato-peeler* (peeler))
(send *potato-peeler* :transform (make-coords :pos (float-vector 600.0 2200.0 920.0) :rot #2f((1.0 0.0 0.0) (0.0 1.0 0.0) (0.0 0.0 1.0))))
(send *potato-peeler* :rotate (deg2rad 180) :z :world)
(send *potato-peeler* :rotate (deg2rad -90) :x :world)

(objects (list *pr2* *cutting-board* *peeler* *knife* *potato-peeler* *kitchen*))
