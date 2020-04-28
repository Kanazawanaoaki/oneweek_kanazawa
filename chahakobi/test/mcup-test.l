(load "../euslisp/model/measuring-cup.l")
(setq *hoge* (measuring-cup))

(load "models/arrow-object.l")
(setq *axis0* (arrow))
(setq *axis1* (arrow))
(setq *axis2* (arrow))

(send *axis0* :move-to (send (car (send *hoge* :handle)) :worldcoords) :world)
(send *axis1* :move-to (send (car (send *hoge* :attention)) :worldcoords) :world)
(send *axis2* :move-to (send (elt (send *hoge* :attention) 1) :worldcoords) :world)

(objects (list *hoge* *axis2*))
