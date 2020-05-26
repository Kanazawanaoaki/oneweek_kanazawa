#!/usr/bin/env roseus

(ros::load-ros-manifest "roseus")
(require "package://pr2eus/pr2-interface.l")

(if (not
     (boundp '*pr2*))
    (pr2-init))
(if (not
     (boundp '*irtviewer*))
    (make-irtviewer))
(send *irtviewer* :objects *pr2*)

(setq *manip-pose* #f(131.783 54.9158 -1.3071 0.272882 -88.7191 -357.653 -5.85497 360.042 -45.3354 1.53671 2.39065 -95.778 -1.10987 -5.93392 359.975 1.67125 48.912))

(setq *init-pose* (float-vector 12.0 45.0 60.0 0.0 -120.0 0.0 -45.0 0.0 -45.0 60.0 0.0 -120.0 0.0 -45.0 0.0 0.0 35.0))

(setq *goal-pos* (make-coords :pos #f(600 0 700)))

(setq *table* nil)

(defun generate-scene-model()
  (setq *table* (make-cube 500 1000 700))
  (send *table* :translate #f(700 0 350))
  (send *table* :set-color #f(0.87 0.72 0.53))
  (objects *table*)
  )

(defun get-all-links (l)
  (let ((r (list l)))
    (dolist (d (send l :descendants))
      (when (derivedp d bodyset-link)
        (setq r (append r (get-all-links d)))))
    r))

(defun collision-check(box &optional (arm :larm))
  (let (res)
    (dolist (link (get-all-links (car (send *pr2* arm :links))))
      (send link :worldcoords)
      (send link :draw-on :flush t)
      ;; (dolist (box *boxes*)
      (setq res (pqp-collision-check link box))
      (ros::ros-info (format nil "Checking :~A" link))
        (when (eq res 1)
          (ros::ros-fatal (format nil "check arm collision failed:~A" res))
          (return-from collision-check nil))
	;; )
      ) t)
  )


(defun main-run1()
  (generate-scene-model)
  (send *pr2* :larm :inverse-kinematics *goal-pos*)
  (send *irtviewer* :draw-objects)
  (collision-check *table* :larm)
  )

;; collision without error reported
(defun main-run2()
  (generate-scene-model)
  (setq test-pos (copy-object *goal-pos*))
  (send test-pos :locate #f(700 -10 500) :world)
  (send *pr2* :larm :inverse-kinematics test-pos :rotation-axis :z)
  (send *irtviewer* :draw-objects)
  (collision-check *table* :larm)
  )

(send *pr2* :angle-vector *manip-pose*)
(send *irtviewer* :draw-objects)
