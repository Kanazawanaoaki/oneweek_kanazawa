(load "mcup-update-model.l")
(setq *mcup* (measuring-cup))

(send *mcup* :translate #f(0 100 100) :world)
(send *mcup* :copy-worldcoords)

;; (setq *nakami* (send *mcup* :content))
;; (send *nakami* :set-color :cyan 0.5)

;; (objects (list *mcup* *nakami*))


;; (setq *water* (send *mcup* :water :surface 90))
;; (send *water* :set-color :cyan 0.5)

;; (objects (list *mcup* *water*))


(setq *bottom* (send *mcup* :bottom))

(objects (list *mcup* *bottom*))
