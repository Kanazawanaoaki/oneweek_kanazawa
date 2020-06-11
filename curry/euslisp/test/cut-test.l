(setq b1 (make-sphere 40))

(defun body-cut-y (abody box)
  (let (b1 b2)
    (send box :locate #f(0 -1 0))
    (setq b1 (body- abody box))
    (setq b2 (body- abody b1))
    (list b1 b2))) 

(defun dev-2-y (abody)
  (let (b box b1 b2)
    (setq b (make-bounding-box (send abody :vertices)))

    (setq m (v- (send b :maxpoint) (send b :minpoint)))
    (setq m2 (v+ (send b :maxpoint) (send b :minpoint)))
    (setq m2 (float-vector (/ (elt m2 0) 2) (/ (elt m2 1) 2) (/ (elt m2 2) 2)))
    
    (setq box (make-cube (* (elt m 0) 2) (* (elt m 1) 2) (* (elt m 2) 2)))
    (send box :locate m2)
    (send box :locate (float-vector 0 (* 1 (elt m 1))  0))

    ;; (objects (list box abody))

    (body-cut-y abody box)))


(defun body-cut-x (abody box)
  (let (b1 b2)
    (send box :locate #f(-1 0 0))
    (setq b1 (body- abody box))
    (setq b2 (body- abody b1))
    (list b1 b2))) 

(defun dev-2-x (abody)
  (let (b box b1 b2)
    (setq b (make-bounding-box (send abody :vertices)))

    (setq m (v- (send b :maxpoint) (send b :minpoint)))
    (setq m2 (v+ (send b :maxpoint) (send b :minpoint)))
    (setq m2 (float-vector (/ (elt m2 0) 2) (/ (elt m2 1) 2) (/ (elt m2 2) 2)))
    
    (setq box (make-cube (* (elt m 0) 2) (* (elt m 1) 2) (* (elt m 2) 2)))
    (send box :locate m2)
    (send box :locate (float-vector (* 1 (elt m 0)) 0 0))

    ;; (objects (list box abody))

    (body-cut-x abody box)))


(setq b-list (dev-2-y b1))

(setq b2 (elt b-list 0))
(setq b3 (elt b-list 1))


(send b2 :translate #f(0 -30 0))
(send b3 :translate #f(0 30 0))

(objects (list b2 b3))

(send *viewer* :draw-objects)


(warn "please run (one-more)~%")

(defun one-more ()
  (setq b-list (dev-2-y b2))
  
  (setq b4 (elt b-list 0))
  (setq b5 (elt b-list 1))

  (send b4 :translate #f(0 -10 0))
  (send b5 :translate #f(0 10 0))

  (objects (list b3 b4 b5))
  (warn "please run (more)~%")
  )


(defun more ()
  (setq b-list (dev-2-x b3))
  
  (setq b6 (elt b-list 0))
  (setq b7 (elt b-list 1))

  (send b6 :translate #f(-10 0 0))
  (send b7 :translate #f(10 0 0))

  (objects (list b6 b7 b4 b5))
  )

