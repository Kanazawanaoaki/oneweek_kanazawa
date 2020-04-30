;; (load "models/kettle-object.l")
;; (setq *kettle* (kettle))

;; (objects (list *kettle*))


(load "../euslisp/model/kettle-body.l")
(setq *kettle* (kettle-body))

(load "models/arrow-object.l")
(setq *axis0* (arrow))
(setq *axis1* (arrow))
(setq *axis2* (arrow))

(send *axis0* :move-to (send (car (send *kettle* :handle)) :worldcoords) :world)
(send *axis1* :move-to (send (car (send *kettle* :attention)) :worldcoords) :world)
(send *axis2* :move-to (send (elt (send *kettle* :attention) 1) :worldcoords) :world)

(objects (list *kettle* *axis0* *axis1*))
