;; Before run you need to do 'source ~/ros/jsk_hrp2_ws/devel/setup.bash 

;; (load "./eus_animation_robot_lib.l")
(load "package://eus_animation/euslisp/eus_animation_robot_lib.l")
(eus_anim::init-simulation)
;; (objects (list *robot*))

(format t "start sim for (eus_anim::test-proc-loop :stop-tm 3), reset sim (eus_anim::reset-simulation)~%")
