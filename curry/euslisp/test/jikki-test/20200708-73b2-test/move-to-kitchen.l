(load "../model/my-room73b2-scene.l")
(setq *room* (room73b2))

(load "package://pr2eus/pr2-interface.l")
(pr2-init)

(load "package://jsk_fetch_startup/euslisp/navigation-utils.l")


;; set spots
(setq *cook-spot* (send *room73b2* :spot "cook-spot"))
(setq *sink-spot* (make-coords :pos #f(1055 2600 0) :rpy #f(3.14 0 0))) 
(setq *desk-spot* (make-coords :pos #f(3470 -1900 0) :rpy #f(-1.57 0 0)))

(setq *kitchen-spot* (send *room73b2* :spot "kitchen-spot"))
(setq */eng2/7f/room73B2-front-of-kitchenboard* (send *room73b2* :spot "/eng2/7f/room73B2-front-of-kitchenboard"))

;; キッチンの場所まで移動

(defun move-to-kitchen-irt ()
  (send *pr2* :move-to *kitchen-spot* :world)
  )
(defun move-to-kitchenboard-irt ()
  (send *pr2* :move-to */eng2/7f/room73B2-front-of-kitchenboard* :world)
  )

(defun move-to-kitchen-ri ()
  (send *ri* :speak-jp "台所まで移動します")
  (send *ri* :clear-costmap)
  (send *ri* :move-to (make-coords :pos #f(1100 8500 351) :rpy (float-vector pi 0 0)) :frame-id "/map") ;; need change value 
  (send *ri* :wait-interpolation))

(defun move-to-kitchenboard-ri ()
  (go-to-spot "/eng2/7f/room73B2-front-of-kitchenboard")
  )

(defun set-pose ()
  (send *pr2* :reset-manip-pose)
  (send *pr2* :torso_lift_joint :joint-angle 325)
  (send *viewer* :draw-objects)
  (send *ri* :angle-vector (send *pr2* :angle-vector) 4000)
  (send *ri* :wait-interpolation)
  )

(move-to-kitchen-irt)

(objects (list *room* *pr2*))
(send *irtviewer* :look-all
      (geo::make-bounding-box 
       (flatten (send-all (send *pr2* :bodies) :vertices))))


(warn "please run (move-to-kitchen-ri) or (move-to-kitchenboard-ri) and (set-pose)~%")
;; (move-to-kitchen-ri)
