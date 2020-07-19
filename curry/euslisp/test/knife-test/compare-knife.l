(load "knife-new-type.l")
(setq *new-knife* (knife))
(load "../../model/my-knife.l")
(setq *now-knife* (knife))

(send *new-knife* :translate #f(0 0 100))

(objects (list *new-knife* *now-knife*))

