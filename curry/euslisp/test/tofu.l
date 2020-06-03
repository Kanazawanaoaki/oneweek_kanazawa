(defclass tofu
  :super bodyset-link
  :slots ())

(defmethod tofu
  (:init
   (&rest args)
   (let (b)
     (setq b (make-cube 200 150 80))
     (send b :set-color :gray90)
     (send-super* :init (make-cascoords) :bodies (list b) args)))
  (:cut-x
   ()
   (let (r b1 b2 m c p)
     ;; for all bodies
     (dolist (abody geo::bodies)
       ;; (setq body abody)
       ;; (setq hoge (send abody :csg))
       (setq m (cdar (send abody :csg))) ;; get w/d/h
       (setq c (send abody :get :face-color))
       (setq p (send abody :pos))
       ;; generate half size cube
       (setq b1 (make-cube (- (/ (elt m 0) 2) 1) (elt m 1) (elt m 2)))
       (setq b2 (make-cube (- (/ (elt m 0) 2) 1) (elt m 1) (elt m 2)))
       ;; move generated bodies
       (send b1 :locate (v+ p (float-vector (/ (elt m 0) 4) 0 0)))
       (send b2 :locate (v+ p (float-vector (/ (elt m 0) -4) 0 0)))
       (send self :assoc b1)
       (send self :assoc b2)
       (print (v+ p (float-vector (/ (elt m 0) 4) 0 0)))
       ;; use original color
       (send b1 :set-color c)
       (send b2 :set-color c)
       ;; push generated bodies to r
       (push b1 r)
       (push b2 r)
       )
     ;; replace geo::bodies with new bodies
     (setq geo::bodies r)))
  (:cut-z
   ()
   (let (r b1 b2 m c p)
     ;; for all bodies
     (dolist (abody geo::bodies)
       ;; (setq body abody)
       ;; (setq hoge (send abody :csg))
       (setq m (cdar (send abody :csg))) ;; get w/d/h
       (setq c (send abody :get :face-color))
       (setq p (send abody :pos))
       ;; generate half size cube
       (setq b1 (make-cube (elt m 0) (elt m 1) (- (/ (elt m 2) 2) 1)))
       (setq b2 (make-cube (elt m 0) (elt m 1) (- (/ (elt m 2) 2) 1)))
       ;; move generated bodies
       (send b1 :locate (v+ p (float-vector 0 0 (/ (elt m 2) 4))))
       (send b2 :locate (v+ p (float-vector 0 0 (/ (elt m 2) -4))))
       (send self :assoc b1)
       (send self :assoc b2)
       (print (v+ p (float-vector 0 0 (/ (elt m 2) 4))))
       ;; use original color
       (send b1 :set-color c)
       (send b2 :set-color c)
       ;; push generated bodies to r
       (push b1 r)
       (push b2 r)
       )
     ;; replace geo::bodies with new bodies
     (setq geo::bodies r)))
  (:cut-y
   ()
   (let (r b1 b2 m c p)
     ;; for all bodies
     (dolist (abody geo::bodies)
       ;; (setq body abody)
       ;; (setq hoge (send abody :csg))
       (setq m (cdar (send abody :csg))) ;; get w/d/h
       (setq c (send abody :get :face-color))
       (setq p (send abody :pos))
       ;; generate half size cube
       (setq b1 (make-cube (elt m 0) (- (/ (elt m 1) 2) 1) (elt m 2)))
       (setq b2 (make-cube (elt m 0) (- (/ (elt m 1) 2) 1) (elt m 2)))
       ;; move generated bodies
       (send b1 :locate (v+ p (float-vector 0 (/ (elt m 1) 4) 0)))
       (send b2 :locate (v+ p (float-vector 0 (/ (elt m 1) -4) 0)))
       (send self :assoc b1)
       (send self :assoc b2)
       (print (v+ p (float-vector 0 (/ (elt m 1) 4) 0)))
       ;; use original color
       (send b1 :set-color c)
       (send b2 :set-color c)
       ;; push generated bodies to r
       (push b1 r)
       (push b2 r)
       )
     ;; replace geo::bodies with new bodies
     (setq geo::bodies r)))
  )


(setq *tofu* (instance tofu :init))
(objects (list *tofu*))
(send *tofu* :cut-x)
(objects (list *tofu*))
(send *tofu* :cut-y)
(objects (list *tofu*))
(send *tofu* :cut-z)
(objects (list *tofu*))

;; ;; this requries https://github.com/euslisp/jskeus/pull/560
;; ;; (load "/home/k-okada/catkin_ws/ws_euslisp/src/jskeus/irteus/irtviewer.l")
;; (load "../../tmpfiles/irtviewer.l")

;; (with-save-animgif
;;  "tofu.gif"

;;  (setq *tofu* (instance tofu :init))
;;  (objects (list *tofu*))

;;  (dotimes (i 10)
;;    (x::window-main-one)
;;    (send *irtviewer* :draw-objects)
;;    (unix:usleep 100000))

;;  (send *tofu* :cut-x)

;;  (dotimes (i 10)
;;    (x::window-main-one)
;;    (send *irtviewer* :draw-objects)
;;    (unix:usleep 100000))

;;  (objects (list *tofu*))

;;  (dotimes (i 10)
;;    (x::window-main-one)
;;    (send *irtviewer* :draw-objects)
;;    (unix:usleep 100000))

;;   (send *tofu* :cut-y)

;;   (dotimes (i 10)
;;     (x::window-main-one)
;;     (send *irtviewer* :draw-objects)
;;     (unix:usleep 100000))

;;   (objects (list *tofu*))

;;   (dotimes (i 10)
;;     (x::window-main-one)
;;     (send *irtviewer* :draw-objects)
;;     (unix:usleep 100000))

;;   (send *tofu* :cut-z)

;;   (dotimes (i 10)
;;     (x::window-main-one)
;;     (send *irtviewer* :draw-objects)
;;     (unix:usleep 100000))

;;   (objects (list *tofu*))

;;   (dotimes (i 10)
;;     (x::window-main-one)
;;     (send *irtviewer* :draw-objects)
;;     (unix:usleep 100000))

;;  )
