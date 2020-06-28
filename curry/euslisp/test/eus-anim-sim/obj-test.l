;; You need to do 'source ~/ros/jsk_demo_ws/devel/setup.bash

(load "package://pr2eus/pr2.l")
(setq *robot* (pr2))
;; (load "./eus_animation_robot_lib.l")
(load "package://eus_animation/euslisp/eus_animation_robot_lib.l")
;; (objects (list *robot*))

(setq *myobj* (make-cube 850 400 100))
(send *myobj* :set-color #F(0.5 0.5 0.8))
(send *myobj* :newcoords (make-coords :pos #F(1100 0 1500)))
(eus_anim::add-mesh *myobj*)
(eus_anim::init-simulation)
(objects *myobj*) ;; for visualization

(format t "start sim for (eus_anim::test-proc-loop :stop-tm 3), reset sim (eus_anim::reset-simulation)~%")
