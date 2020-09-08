(load "../../model/potato-new-type.l")

(setq *potato* (potato :w 90 :l 60 :h 60))
(send *potato* :cut)

;; (send p1 :locate #f(0 0 100))
;; (send p3 :locate #f(0 0 -100))

(objects (list *potato*))
