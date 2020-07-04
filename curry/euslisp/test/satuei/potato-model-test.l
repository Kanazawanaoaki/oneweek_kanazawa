(load "../../model/potato-test-model.l")
(setq *potato* (potato))

(load "models/arrow-object.l")
(setq *arrow* (arrow))

(send *potato* :locate #f(0 1000 1000))
(send *potato* :cut)

(send *arrow* :newcoords (send *cut-point-1* :copy-worldcoords))

(objects (list *potato* *arrow*))
