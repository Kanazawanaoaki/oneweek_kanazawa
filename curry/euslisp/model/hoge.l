(defun z-mul (point num)
  (float-vector (elt point 0) (elt point 1) (* (elt point 2) num)))

(setq b1 (make-sphere 45))
(setq v-list (list (z-mul (car (send b1 :vertices)) 0.78)))
(dolist (x (cdr (send b1 :vertices))) (setq v-list (append v-list (list (z-mul x 0.78)))))
(setq b2 (convex-hull-3d v-list))

(setq b3 (make-cylinder 8 2))
(setq v-list (list (car (send b3 :vertices))))
(dolist (x (cdr (send b3 :vertices))) (if (< (elt x 2) 1) (setq v-list (append v-list (list x)))))

(setq b4 (make-cone #f(0 0 20) v-list))
(send b4 :translate #f(0 0 28))

(objects (list b2 b4))




;;Make Takosan Wiener
(defun make-tako ()
  (let (tako c2 c3 c4)
    (setq tako (make-cylinder 20 50))
    (send tako :locate #f(400 -200 -100))
    (send tako :set-color :tomato)
    (setq c2 (make-sphere 20))
    (send c2 :locate #f(400 -200 -50))
    (send c2 :set-color :tomato)
    (setq c3 (make-cube 40 5 10))
    (send c3 :locate #f(400 -200 -95))
    (send c3 :set-color :wheat)
    (setq c4 (make-cube 5 40 10))
    (send c4 :locate #f(400 -200 -95))
    (send c4 :set-color :wheat)
    (send tako :assoc c2)
    (send tako :assoc c3)
    (send tako :assoc c4)
    (instance bodyset-link :init (make-cascoords :pos #f(400 -200 -100)) :bodies (list tako c2 c3 c4))
    ))


;;Make Broccoli
(defun make-bro ()
  (let (bro d2)
    (setq bro (make-sphere 25))
    (send bro :locate #f(400 -280 -50))
    (send bro :set-color :forestgreen)
    (setq d2 (make-cylinder 8 50))
    (send d2 :locate #f(400 -280 -100))
    (send d2 :set-color :green)
    (send bro :assoc d2)
    (instance bodyset-link :init (make-cascoords :pos #f(400 -280 -50)) :bodies (list bro d2))
    ))

;;Make tamagoyaki
(defun make-egg ()
  (let (egg)
    (setq egg (make-cube 38 50 20))
    (send egg :locate #f(300 -200 -90))
    (send egg :set-color :yellow)
    egg))
