(load "../../model/potato-test-model.l")
(setq *potato* (potato))

(load "models/arrow-object.l")
(setq *arrow* (arrow))

(send *potato* :locate #f(0 1000 1000))
(send *potato* :cut)
(send p1 :set-color :saddlebrown)
(send p2 :set-color :saddlebrown)
(send p3 :set-color :saddlebrown)
(send p4 :set-color :saddlebrown)
(send p5 :set-color :saddlebrown)
(send p6 :set-color :saddlebrown)

(send *arrow* :newcoords (send *cut-point-1* :copy-worldcoords))

(objects (list *potato* *arrow*))
