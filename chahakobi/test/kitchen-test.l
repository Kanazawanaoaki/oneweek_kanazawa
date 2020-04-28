(load "models/room73b2-scene.l")
(setq *room73b2* (room73b2))


;; set spots
(setq *cook-spot* (send *room73b2* :spot "cook-spot") )
(setq *sink-spot* (make-coords :pos #f(1055 2600 0) :rpy #f(3.14 0 0))) 
(setq *desk-spot* (make-coords :pos #f(3470 -1900 0) :rpy #f(-1.57 0 0)))

;; set points
(setq *water-point* (make-coords :pos #f(340.0 2580.0 880.0) :rpy #f(3.14 0 0)))                
(setq *faucet-point* (make-coords :pos #f(200 2580 950) :rpy #f(3.14 0 0)))
(setq *cook-point0* (make-coords :pos #f(500.0 1500.0 825.0) :rpy #f(-3.14 0 0)))
(setq *cook-switch-point* (make-coords :pos #f(660 1550 710) :rpy #f(3.142 0 -1.571)))
(setq *desk-point* (make-coords :pos #f(3470 -2500 700) :rpy #f(1.571 0 0)))


(load "models/arrow-object.l")
(setq *axis0* (arrow))
(setq *axis1* (arrow))
(setq *axis2* (arrow))
(setq *axis3* (arrow))
(setq *axis4* (arrow))
(setq *axis5* (arrow))

(send *axis0* :move-to *water-point* :world)
(send *axis1* :move-to *faucet-point* :world)
(send *axis2* :move-to *cook-point0* :world)
(send *axis3* :move-to *cook-switch-point* :world)
(send *axis4* :move-to *cook-spot* :world)
(send *axis5* :move-to *sink-spot* :world)

;; set kettle
(setq *kettle* (send *room73b2* :object "room73b2-kettle"))  
(if (send *kettle* :parent) (send (send *kettle* :parent) :dissoc *kettle*))
(send *kettle* :locate #f(0 0 -500))


(objects (list *room73b2* *axis0* *axis1* *axis2* *axis3* *axis4* *axis5*))
