(load "package://pr2eus/pr2.l")
(setq *robot* (pr2))

(load "../euslisp/model/kettle-body.l")
(setq *kettle* (kettle-body))
(send *kettle* :locate #f(600 0 400))

(load "../euslisp/model/measuring-cup.l")
(setq *cup* (measuring-cup))
(send *cup* :locate #f(600 200 550))

(load "models/arrow-object.l")
(setq *arrow* (arrow))
(send *arrow* :newcoords (send (car (send *cup* :handle)) :worldcoords))

(objects (list *robot* *kettle* *cup* *arrow*))

(send *arrow* :rotate (deg2rad 180) :z :world)
(send *robot* :larm :inverse-kinematics
      *arrow*
      :rotational-axis nil
      :debug-view t)
(send *robot* :larm :end-coords :assoc *cup*)
(send *arrow* :move-to (send (elt (send *kettle* :attention) 1) :worldcoords) :world)

(send *arrow* :locate #f(0 0 50))
(send *arrow* :rotate (deg2rad 100) :x :world)
(send *robot* :larm :inverse-kinematics
      *arrow*
      :move-target (car (send *cup* :attention))
      :rotation-axis :t
      :debug-view t))

