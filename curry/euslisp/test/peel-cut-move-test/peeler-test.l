(load "../../model/peeler.l")
(setq *peeler* (peeler))

(load "models/arrow-object.l")
(setq *arrow* (arrow))
(send *arrow* :newcoords (send (car (send *peeler* :attention)) :copy-worldcoords))



(objects (list *peeler* *arrow*))
