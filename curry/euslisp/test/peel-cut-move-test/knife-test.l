(load "../../model/my-knife.l")
(setq *knife* (knife))

(load "models/arrow-object.l")
(setq *arrow* (arrow))
(send *arrow* :newcoords (send (car (send *knife* :attention)) :copy-worldcoords))


(objects (list *knife* *arrow*))
