(load "../../model/bowl-1.l")
(setq *bowl* (bowl-1))

(load "models/arrow-object.l")
(setq *arrow* (arrow))

(send *bowl* :translate #f(0 100 1000))


(objects (list *bowl*))

(defun show-coords ()
  (send (send *bowl* :handle-handle0) :draw-on :flush t :size 80 :width 10 :color #f(0 1 0))
  (send (send *bowl* :attention-attention0) :draw-on :flush t :size 80 :width 10 :color #f(0 0 1))
  (send (send *bowl* :attention-attention1) :draw-on :flush t :size 80 :width 10 :color #f(0 0 1))
  )

(show-coords)
