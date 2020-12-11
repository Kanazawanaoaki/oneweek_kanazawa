(load "package://pr2eus/pr2-interface.l")
(pr2-init)
(setq *cds* (make-cascoords))
  

(defun init-pose ()
  (send *pr2* :angle-vector #f(325.0 60.0 74.0 70.0 -120.0 20.0 -30.0 180.0 10.9622 7.67527 -26.7165 -50.7115 -197.326 -50.1739 578.54 0.0 0.0))
  (send *ri* :angle-vector (send *pr2* :angle-vector))
  (send *ri* :wait-interpolation)
  
  (print (send *pr2* :angle-vector))
  (print (send *ri* :state :potentio-vector))
  (send *ri* :state :potentio-vector)
  )

(init-pose)

(warn "please run (bag-test) or (no-bag-test) ~%")

(defun hoge ()
  
  (send *cds* :newcoords (send (send *pr2* :rarm :end-coords) :copy-worldcoords))
  
  (setq avs (list))
  (setq tms (list))
  
  (dotimes (i 8)
    (send *cds* :rotate (deg2rad 45) :x :world)
    (send *pr2* :rarm :inverse-kinematics
	  *cds*
	  :rotation-axis t
	  :debug-view nil)
    (send *viewer* :draw-objects)
    (setq av (send *pr2* :angle-vector))
    (setq avs (append avs (list av)))
    (setq tms (append tms (list 200)))
    )

  (print avs)
  (print tms)
  (send *ri* :angle-vector-sequence avs tms)
  (send *ri* :wait-interpolation)
  )


(defun hoge2 ()
  (send *pr2* :angle-vector (send *ri* :state :potentio-vector))
  (send *cds* :newcoords (send (send *pr2* :rarm :end-coords) :copy-worldcoords))
  
  (setq avs (list))
  (setq tms (list))
  
  (dotimes (i 8)
    (send *cds* :rotate (deg2rad 45) :x :world)
    (send *pr2* :rarm :inverse-kinematics
	  *cds*
	  :rotation-axis t
	  :debug-view nil)
    (send *viewer* :draw-objects)
    (setq av (send *pr2* :angle-vector))
    (setq avs (append avs (list av)))
    (setq tms (append tms (list 200)))
    )

  (print avs)
  (print tms)
  (send *ri* :angle-vector-sequence avs tms)
  (send *ri* :wait-interpolation)
  )


(defun bag-test ()
  (init-pose)
  (hoge)
  )

(defun no-bag-test ()
  (init-pose)
  (hoge2)
  )


