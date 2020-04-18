(load "package://pr2eus/pr2.l")
(load "package://pr2eus/pr2-interface.l")
(load "models/kettle-object.l")
(load "models/arrow-object.l")

(pr2-init)

(setq *robot* (pr2))
(setq *kettle* (kettle))
(setq *axis* (arrow))

(objects (list *robot* *kettle* *axis*))

(if (send *ri* :simulation-modep)
    (progn
      (send *ri* :objects *kettle*))
   ))


(send *robot* :newcoords (make-coords))
(send *robot* :reset-pose)
(send *ri* :angle-vector (send *robot* :angle-vector) 1000)

(send *kettle* :newcoords (make-coords))
(send *kettle* :translate #f(600 -200 700))
(send *axis* :newcoords (send *kettle* :copy-worldcoords))
(send *axis* :transform (car (send *kettle* :handle)))

(send *robot* :rarm :inverse-kinematics *axis*)
(send *ri* :angle-vector (send *robot* :angle-vector) 1000)

(send (send *robot* :rarm :end-coords :parent) :assoc *axis*)
(send (send *robot* :rarm :end-coords :parent) :assoc *kettle*)
(send *robot* :reset-pose)
(send *ri* :angle-vector (send *robot* :angle-vector) 1000)
