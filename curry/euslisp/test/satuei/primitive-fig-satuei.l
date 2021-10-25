(load "package://jsk_2020_04_pr2_curry/euslisp/cook-with-pos-map/primitive/my-cook-primitive-funcs.l")
(load "models/arrow-object.l")
(setq *arrow* (arrow))
(send *arrow* :newcoords (make-coords :pos #f(800 0 1000)))

(objects (list *pr2*))

(move-arm-ik *arrow*)

(send (send *pr2* :rarm :end-coords) :draw-on :flush t :size 100 :width 10 :color #f(1 0 0))
