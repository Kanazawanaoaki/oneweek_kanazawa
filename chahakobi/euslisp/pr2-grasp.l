(load "package://pr2eus/pr2-interface.l")

(pr2-init t) ;; t means create-viewer

;; spawn magic box
(setq *b* (make-cube 30 30 1000))
(send *b* :locate #f(750 0 750) :world)
(objects (list *pr2* *b*))
(send *ri* :objects (list (copy-object *b*))) ;; insert object int kinetmatics world

(ros::ros-info "reset pose")
(send *pr2* :reset-pose)
(send *ri* :angle-vector (send *pr2* :angle-vector))
(send *ri* :wait-interpolation)

(ros::ros-info "open hand")
(send *pr2* :stop-grasp :larm) ;; on real robot, try (send *ri* :stop-grasp :larm)
(send *ri* :stop-grasp :larm)

(ros::ros-info "look at target")
(send *pr2* :head :look-at (send *b* :worldpos))
(send *ri* :angle-vector (send *pr2* :angle-vector))
(send *ri* :wait-interpolation)

(ros::ros-info "reach object")
(send *pr2* :larm :inverse-kinematics (send *b* :worldcoords) :look-at-target t :debug-view :no-message)
(send *ri* :angle-vector (send *pr2* :angle-vector))
(send *ri* :wait-interpolation)

(ros::ros-info "grasp object")
(send *pr2* :start-grasp :larm *b*) ;; simulation only, this tells *pr2* to grasp *b*
(send *ri* :start-grasp :larm) ;; *ri* autoatically checks collision between gripper and (send *ri* :objects)a

(ros::ros-info "lift object")
(send *pr2* :larm :move-end-pos #f(0 0 100) :world :look-at-target t :debug-view :no-message)
(send *ri* :angle-vector (send *pr2* :angle-vector))
(send *ri* :wait-interpolation)

(ros::ros-info "release object")
(send *pr2* :stop-grasp :larm)
(send *ri* :stop-grasp :larm)

(ros::ros-info "reset pose")
(send *pr2* :reset-pose)
(send *ri* :angle-vector (send *pr2* :angle-vector))
(send *ri* :wait-interpolation)

(ros::ros-info "close hand")
(send *pr2* :start-grasp :larm)
(send *ri* :start-grasp :larm)
(send *irtviewer* :draw-objects)
