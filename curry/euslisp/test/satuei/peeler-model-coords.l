(load "../../model/peeler.l")
(setq *peeler* (peeler))

(load "models/arrow-object.l")
(setq *arrow* (arrow))


(send *peeler* :translate #f(0 100 1000))
;; (send *arrow* :newcoords (send (send *peeler* :handle-handle1) :copy-worldcoords))


(objects (list *peeler*))

(defun show-coords ()
  (send (send *peeler* :handle-handle1) :draw-on :flush t :size 80 :width 10 :color #f(0 1 0))
  (send (send *peeler* :attention-attention0) :draw-on :flush t :size 80 :width 10 :color #f(0 0 1))
  )

(show-coords)
