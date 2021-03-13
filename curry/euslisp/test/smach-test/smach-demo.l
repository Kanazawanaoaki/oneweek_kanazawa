#!/usr/bin/env roseus

(load "package://roseus_smach/src/state-machine.l")
(load "package://roseus_smach/src/state-machine-ros.l")
(load "package://roseus_smach/src/state-machine-utils.l")

(load "kettle-demo.l")

(defun smach-kettle-demo ()
  (let (sm)
    (setq count 0) ;; comment in for :fail demo
    (setq sm
          (make-state-machine
           ;; define graph,  list of (<from-node> <transition> <to-node>)
           ;; if <transition> is ->, it corresponds when node returns t and !-> for nil.
           '((:init :success :move-to-cook-spot)
             (:move-to-cook-spot :success :reach-kettle)
             (:reach-kettle :success :grab-kettle)
             (:reach-kettle :fail :init) ;; comment in for :fail demo
             (:grab-kettle :success :move-to-table)
             (:move-to-table :success :release-kettle)
             (:release-kettle :success :done)
             )
           ;; define function map
           '((:init '(lambda (&rest args) (init) :success))
             (:move-to-cook-spot '(lambda (&rest args) (move-to-cook-spot) :success))
             ;; (:reach-kettle '(lambda (&rest args) (reach-kettle) :success)) ;; comment out for :fail demo
             (:reach-kettle '(lambda (&rest args) (reach-kettle) (if (< (incf count) 3) :fail :success))) ;; comment in for :fail demo, run reach-kettle 3 times
             (:grab-kettle '(lambda (&rest args) (grab-kettle) :success))
             (:move-to-table '(lambda (&rest args) (move-to-table) :success))
             (:release-kettle '(lambda (&rest args) (release-kettle) :success))
             )
           ;; initial state
           '(:init)
           ;; goal state
           '(:done)))))

(defun smach-demo ()
  (ros::roseus "smach_demo")
  (exec-state-machine (smach-kettle-demo)))

(format t ";; to run with smach, run
(smach-demo)
")
