(load "package://pr2eus/pr2-interface.l")
(pr2-init)
(setq *cds* (make-cascoords))

(objects (list *pr2*))

(send *cds* :newcoords (send (send *pr2* :rarm :end-coords) :copy-worldcoords))


;; add for rosservice
(ros::load-ros-manifest "std_srvs")
(ros::wait-for-service "after_stow_data_collection/save_request")
(setq req (instance std_srvs::TriggerRequest :init))



(defun test ()
  (send *ri* :angle-vector (send *pr2* :angle-vector))
  (send *ri* :wait-interpolation)
  
  (unix:sleep 1)
  
  (setq res (ros::service-call "after_stow_data_collection/save_request" req t))
  )

(defun ik-test ()
  (send *cds* :translate #f(100 0 100) :world)
  (send *pr2* :rarm :inverse-kinematics *cds*)
  (test)
  )

(warn "please run (ik-test) ~%")
