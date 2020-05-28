;; definition of link
;; (setq b1 (make-cylinder 30 2))
;; (send b1 :translate #f(100 0 0))
;; (send b1 :rotate (deg2rad -90) :y)

;; (send b1 :worldcoords)

(setq v-list (list #f(100.0 -15.0 25.9808) #f(100.0 -25.9808 15.0) #f(100.0 -30.0 -4.085621e-14) #f(100.0 -25.9808 -15.0) #f(100.0 -15.0 -25.9808) #f(100.0 2.842171e-14 -30.0) #f(100.0 15.0 -25.9808) #f(100.0 25.9808 -15.0) #f(100.0 30.0 1.598721e-14) #f(100.0 25.9808 15.0) #f(100.0 15.0 25.9808) #f(100.0 0.0 30.0)))

;; (setq v-list (list (car (send b1 :vertices))))
;; (dolist (x (cdr (send b1 :vertices))) (if (> (elt x 0) 99) (setq v-list (append v-list (list x)))))

(setq b2 (make-cone #f(-100 0 0) v-list))

(setq b3 (make-sphere 30))
(send b3 :locate #f(100 0 0))

(setq b4 (make-cube 100 100 100))
(send b4 :translate #f(49 0 0))
;; (setq b3 (body- b3 b4))
(setq p1 (body- b3 b4))

(setq b5 (make-cube 100 100 100))
(send b5 :translate #f(-110 0 0))
(setq p2 (body- b2 b5))

(setq p3 (body- b2 p2))

(send p1 :set-color :orangered)
(send p2 :set-color :orangered)
(send p3 :set-color :orangered)

;; (send b2 :assoc b3)

(setq *cut-point-1* (make-cascoords :pos #f(100 0 0)))
(send *cut-point-1* :rotate (deg2rad 90) :z)

(setq *cut-point-2* (make-cascoords :pos #f(-60 0 0)))
(send *cut-point-2* :rotate (deg2rad 90) :z)

(load "models/arrow-object.l")
(setq *arrow* (arrow))
(send *arrow* :move-to *cut-point-2* :world)

(send p3 :translate #f(0 0 -50))

(objects (list *arrow* p1 p2 p3))

