(load "package://pr2eus/pr2.l")
(setq *robot* (pr2))

(load "models/kettle-object.l")
(setq *kettle* (kettle))
(send *kettle* :locate #f(600 200 550))

(load "models/mug-cup-object.l")
(setq *cup* (mug-cup))
(send *cup* :locate #f(600 0 400))

(load "models/arrow-object.l")
(setq *arrow* (arrow))
(send *arrow* :newcoords (send (car (send *kettle* :handle)) :worldcoords))

(objects (list *robot* *kettle* *cup* *arrow*))

(send *robot* :larm :inverse-kinematics
      *arrow*
      :rotational-axis nil
      :debug-view t)
(send *robot* :larm :end-coords :assoc *kettle*)
(send *arrow* :move-to (send (elt (send *cup* :attention) 0) :worldcoords) :world)

(send *arrow* :rotate (deg2rad 60) :x :world)
(send *robot* :larm :inverse-kinematics
      *arrow*
      :move-target (car (send *kettle* :attention))
      :rotation-axis :t
      :debug-view t))

