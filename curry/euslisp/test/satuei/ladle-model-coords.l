(load "../../model/ladle.l")
(setq *ladle* (ladle))

(load "models/arrow-object.l")
(setq *arrow* (arrow))


(send *ladle* :translate #f(0 100 1000))
;; (send *arrow* :newcoords (send (send *ladle* :handle-handle1) :copy-worldcoords))


(objects (list *ladle*))

(defun show-coords ()
  (send (send *ladle* :handle-handle0) :draw-on :flush t :size 80 :width 10 :color #f(0 1 0))
  (send (send *ladle* :attention-attention0) :draw-on :flush t :size 80 :width 10 :color #f(0 0 1))
  )

(show-coords)
