(load "package://eus_qp/optmotiongen/euslisp/inverse-kinematics-wrapper.l")
(load "package://eus_qp/optmotiongen/euslisp/discrete-kinematics-configuration-task.l")
(load "package://eus_qp/optmotiongen/euslisp/sqp-msc-optimization.l")
(require "irteus/demo/sample-arm-model.l")
(require "models/arrow-object.l")

;; (load "package://eus_qp/optmotiongen/euslisp/instant-configuration-task.l")
;; (load "package://eus_qp/optmotiongen/euslisp/sqp-optimization.l")
;; (load "package://eus_qp/optmotiongen/euslisp/validate-jacobian.l")
;; (load "package://eus_qp/optmotiongen/euslisp/robot-object-environment.l")
;; (require :pr2 "package://pr2eus/pr2-interface.l")
;; (require "models/room73b2-askul-1200x700-desk-0-object.l")

(defun sample-arm-reach-ik-obstacle
    (&key
     (irteus-ik? nil)
     (pre-process-func)
     (post-process-func)
     &allow-other-keys
     )
  (setq *robot* (instance sarmclass :init))
  (setq *arrow* (instance arrow-object :init))
  (send *arrow* :newcoords
        (make-coords :pos (float-vector 400 -200 300) :rpy (list (deg2rad 60) 0 0)))
  (setq *obstacle* (make-cube 250 250 250))
  (send *obstacle* :newcoords
        (make-coords :pos (float-vector 200 -200 600)))
  (send *obstacle* :set-color (float-vector 1 0 0) 0.5)
  (objects (list *robot* *arrow* *obstacle*))

  (send *robot*
        (if irteus-ik? :inverse-kinematics :inverse-kinematics-optmotiongen)
        (send *arrow* :copy-worldcoords)
        :link-list (send *robot* :link-list (send (send *robot* :end-coords) :parent))
        :move-target (send *robot* :end-coords)
        :translation-axis t
        :rotation-axis nil
        :debug-view t
        :obstacles (list *obstacle*)
        :pre-process-func pre-process-func
        :post-process-func post-process-func
        )
  )
(warn "(sample-arm-reach-ik-obstacle)~%")
