(load "mcup-update-model.l")
(setq *mcup* (measuring-cup))

(setq *nakami* (send *mcup* :content))
(send *nakami* :set-color :cyan 0.5)

;; (objects (list *mcup* *nakami*))


(setq *water* (send *mcup* :water :surface 90))
(send *water* :set-color :cyan 0.5)

(objects (list *mcup* *water*))
