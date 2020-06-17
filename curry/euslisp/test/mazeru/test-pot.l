(load "pot.l")
(setq *pot* (cooking-pot))

;; (setq *nakami* (send *pot* :content))
;; (send *nakami* :set-color :cyan 0.5)

(setq *nakami* (send *pot* :water))
(send *nakami* :set-color :cyan 0.6)

(objects (list *pot* *nakami*))

