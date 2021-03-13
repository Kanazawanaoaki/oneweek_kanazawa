(load "../../model/measuring-cup-73b2.l")
(setq *mcup* (measuring-cup-73b2))

(load "models/arrow-object.l")
(setq *arrow* (arrow))


(send *mcup* :translate #f(0 100 1000))
;; (send *arrow* :newcoords (send (send *mcup* :handle-handle1) :copy-worldcoords))


(objects (list *mcup*))

(defun show-coords ()
  (send (send *mcup* :handle-handle1) :draw-on :flush t :size 80 :width 10 :color #f(0 1 0))
  (send (send *mcup* :attention-attention0) :draw-on :flush t :size 80 :width 10 :color #f(0 0 1))
  (send (send *mcup* :attention-attention1) :draw-on :flush t :size 80 :width 10 :color #f(0 0 1))
  )

(show-coords)
