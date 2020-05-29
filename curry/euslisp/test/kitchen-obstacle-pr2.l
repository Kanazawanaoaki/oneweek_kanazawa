(load "package://eus_qp/optmotiongen/euslisp/inverse-kinematics-wrapper.l")
(load "package://eus_qp/optmotiongen/euslisp/discrete-kinematics-configuration-task.l")
(load "package://eus_qp/optmotiongen/euslisp/sqp-msc-optimization.l")
(require "irteus/demo/sample-arm-model.l")
(require "package://pr2eus/pr2.l")
(require "models/arrow-object.l")

(setq irteus-ik? nil)

;; set robot
(setq *robot* (instance pr2-robot :init))

;; set kitchen
(load "models/room73b2-kitchen-object.l")
(setq *kitchen* (room73b2-kitchen))
(send *kitchen* :locate #f(700 -200 0))
(send *kitchen* :rotate (deg2rad 180) :z :world)

;; set spots
(setq *sink-spot* (make-coords :pos #f(-50 -600 0)))
(setq *kitchen-spot* (make-coords :pos #f(0 0 0)))

;; set points
(setq *water-point* (make-coords :pos #f(670 -600 850)))
(setq *faucet-point* (make-coords :pos #f(810 -600 950)))

(send *robot* :move-to *sink-spot* :world)

;; set arrow
(setq *arrow* (instance arrow-object :init))

(objects (list *robot* *arrow* *kitchen*))

;; set ik target
(send *arrow* :newcoords (send *water-point* :copy-worldcoords))
(send *arrow* :rotate (deg2rad -90) :y)

(send *robot* :reset-manip-pose)
(send *robot* :torso_lift_joint :joint-angle 325)

;; try obstacle ik
(send *robot*
      (if irteus-ik? :inverse-kinematics :inverse-kinematics-optmotiongen)
      (send *arrow* :copy-worldcoords)
      :link-list (send *robot* :link-list (send (send *robot* :larm :end-coords) :parent))
      :move-target (send *robot* :larm :end-coords)
      :translation-axis t
      :rotation-axis nil
      :debug-view t
      :root-virtual-mode :planar
      ;; :collision-avoidance-link-pair (mapcar #'(lambda (l) (list l *kitchen*)) (append (send *robot* :link-list (send *robot* :larm :end-coords :parent)) (list (send *robot* :l_forearm_link_lk) (send *robot* :l_upper_arm_link_lk) (send *robot* :l_gripper_palm_link_lk) (send *robot* :l_gripper_r_finger_link_lk) (send *robot* :l_gripper_l_finger_link_lk) (send *robot* :l_gripper_r_finger_tip_link_lk)(send *robot* :base_link_lk))))
      :collision-avoidance-link-pair (mapcar #'(lambda (l) (list l *kitchen*)) (append (send *robot* :link-list (send *robot* :larm :end-coords :parent)) (list (send *robot* :l_forearm_link_lk) (send *robot* :l_upper_arm_link_lk) (send *robot* :l_gripper_palm_link_lk) (send *robot* :l_gripper_r_finger_link_lk) (send *robot* :l_gripper_l_finger_link_lk) (send *robot* :l_gripper_r_finger_tip_link_lk))))
      )
