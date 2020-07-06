(load "../../model/peeler.l")
(setq *peeler* (peeler))

(load "models/arrow-object.l")
(setq *arrow* (arrow))
(send *arrow* :newcoords (send (car (send *peeler* :attention)) :copy-worldcoords))
(send *arrow* :assoc *peeler*)

(load "../../model/carrot-test-model.l")
(setq *carrot* (carrot))

(objects (list *peeler* *arrow* *carrot*)) 


(setq width 200)
(setq length 60)
(setq height 60)


(send *arrow* :newcoords (send *carrot* :copy-worldcoords))
(send *arrow* :translate (float-vector (/ width 2) 0 (* height 1)))
(send *viewer* :draw-objects)
(unix:sleep 1)

;; 皮剥き始める所
(send *arrow* :translate (float-vector 0 0 (* -1 height)))
(send *viewer* :draw-objects)
(unix:sleep 1)

;; 剥き終わり
(send *arrow* :translate (float-vector (* (+ width 20) -1) 0 0))
(send *viewer* :draw-objects)
(unix:sleep 1)
