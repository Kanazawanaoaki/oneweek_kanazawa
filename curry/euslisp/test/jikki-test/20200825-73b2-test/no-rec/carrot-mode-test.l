(load "carrot-new-type.l")
(setq *carrot* (carrot :w1 20 :w2 180 :l 60 :h 60))

(send *carrot* :cut)

(objects (list *carrot*))
