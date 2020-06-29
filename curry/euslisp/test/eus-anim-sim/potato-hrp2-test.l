;; You need to do 'source ~/ros/jsk_demo_ws/devel/setup.bash

;; (load "./eus_animation_robot_lib.l")
(load "package://eus_animation/euslisp/eus_animation_robot_lib.l")
;; (objects (list *robot*))

(eus_anim::init-simulation)


;; (setq *myobj* (make-cube 850 400 100))

(load "../../model/pot-update-model.l")
(setq *myobj* (cooking-pot))

(send *myobj* :newcoords (make-coords :pos #F(1100 0 1500)))
(send *myobj* :copy-worldcoords)
(eus_anim::disable-use-pdfric)
(eus_anim::add-mesh *myobj*)
(objects *myobj*) ;; for visualization

(format t "start sim for (eus_anim::test-proc-loop :stop-tm 3), reset sim (eus_anim::reset-simulation)~%")
