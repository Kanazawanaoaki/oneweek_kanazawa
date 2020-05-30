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

(setq b5 (make-cube 200 200 200))
(send b5 :translate #f(-70 0 0))
(setq p2 (body- b2 b5))

(setq t1 (body- b2 p2))
(send b5 :translate #f(-90 0 0))
(setq p3 (body- t1 b5))

(setq p4 (body- t1 p3))

(send p1 :set-color :orangered)
(send p2 :set-color :orangered)
(send p3 :set-color :orangered)
(send p4 :set-color :orangered)

(setq *cut-point-1* (make-cascoords :pos #f(100 0 0)))
(send *cut-point-1* :rotate (deg2rad 90) :z)

(setq *cut-point-2* (make-cascoords :pos #f(30 0 0)))
(send *cut-point-2* :rotate (deg2rad 90) :z)

(setq *cut-point-3* (make-cascoords :pos #f(-60 0 0)))
(send *cut-point-3* :rotate (deg2rad 90) :z)
(send *cut-point-3* :rotate (deg2rad 180) :z :world)

(send p2 :assoc *cut-point-1*)
(send p2 :assoc *cut-point-2*)
(send p3 :assoc *cut-point-3*)

(send p2 :assoc p1)
(send p2 :assoc p3)
(send p3 :assoc p4)


(load "models/arrow-object.l")
(setq *arrow* (arrow))
(send *arrow* :move-to *cut-point-2* :world)

;; (send p4 :translate #f(0 0 -50))

(objects (list *arrow* p1 p2 p3 p4))


(warn "please run (c1-1) or (exec-all)~%")

(defun c1-1 ()
  (send *arrow* :newcoords (send *cut-point-1* :copy-worldcoords))

  (send *viewer* :draw-objects)
  (warn "please run (c1-2)~%")
  )

(defun c1-2 ()
  (send p2 :dissoc p1)
  (send p1 :translate #f(30 0 0))

  (send *viewer* :draw-objects)
  (warn "please run (c2-1)~%")
  )

(defun c2-1 ()
  (send *arrow* :newcoords (send *cut-point-2* :copy-worldcoords))

  (send *viewer* :draw-objects)
  (warn "please run (c2-2)~%")
  )

(defun c2-2 ()
  (send p2 :dissoc p3)
  (send p2 :translate #f(20 0 0))

  (send *viewer* :draw-objects)
  (warn "please run (c3-1)~%")
  )

(defun c3-1 ()
  (send *arrow* :newcoords (send *cut-point-3* :copy-worldcoords))

  (send *viewer* :draw-objects)
  (warn "please run (c3-2)~%")
  )

(defun c3-2 ()
  (send p3 :dissoc p4)
  (send p4 :translate #f(-20 0 0))

  (send *viewer* :draw-objects)
  )


(defun exec-all ()
  (c1-1)
  (unix:usleep 1000000)
  (c1-2)
  (unix:usleep 1000000)
  (c2-1)
  (unix:usleep 1000000)
  (c2-2)
  (unix:usleep 1000000)
  (c3-1)
  (unix:usleep 1000000)
  (c3-2)
  )
