;; You need to do 'source ~/ros/jsk_demo_ws/devel/setup.bash

(load "package://pr2eus/pr2.l")
(setq *robot* (pr2))
(send *robot* :translate #f(0 0 10) :world)
;; (load "./eus_animation_robot_lib.l")
(load "package://eus_animation/euslisp/eus_animation_robot_lib.l")
(eus_anim::init-simulation)
(objects (list *robot*))

(format t "start sim for (eus_anim::test-proc-loop :stop-tm 3), reset sim (eus_anim::reset-simulation)~%")
