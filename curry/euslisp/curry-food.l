;; set kitchen
(load "models/room73b2-kitchen-object.l")
(setq *kitchen* (room73b2-kitchen))
(send *kitchen* :locate #f(800 -200 0))
(send *kitchen* :rotate (deg2rad 180) :z :world)

;; set knife
(load "models/knife-object.l")
(setq *knife* (knife))
(send *knife* :locate #f(550.0 -200.0 850.0))

;; set peeler
(load "model/peeler.l")
(setq *peeler* (peeler))
(send *peeler* :locate #f(550.0 -250.0 850.0))

;; set まな板
(load "model/cutting-board.l")
(setq *cutting-board* (cutting-board))
(send *cutting-board* :locate #f(650 0 825))

;; set 調理鍋
(load "model/cooking-pot.l")
(setq *pot* (cooking-pot))
(send *pot* :locate #f(680 500 830))


;; set onion
(load "model/onion-test-model.l")
(setq *onion* (onion))
(send *onion* :locate #f(900 100 845))

;; set carrot
(load "model/carrot-test-model.l")
(setq *carrot* (carrot))
(send *carrot* :locate #f(900 0 845))

;; set potato
(load "model/potato-test-model.l")
(setq *potato* (potato))
(send *potato* :locate #f(900 -100 845))

;; set arrow
(load "models/arrow-object.l")
(setq *arrow* (arrow))

;; set spots
(setq *sink-spot* (make-coords :pos #f(0 -600 0)))
(setq *kitchen-spot* (make-coords :pos #f(0 0 0)))

;; set points
(setq *water-point* (make-coords :pos #f(770 -605 830)))
(setq *trash-point* (make-coords :pos #f(880 -270 835)))

;; set water
(setq *water* (make-cylinder 15 100))
(send *water* :set-color :cyan)
(send *water* :move-to (send *water-point* :copy-worldcoords) :world)


;;defin object list for visialize
(setq obj-list (list *kitchen* *knife* *peeler* *cutting-board* *pot* *onion* *carrot* *potato*))
;; (setq obj-list (list *kitchen* *knife* *peeler* *cutting-board* *pot* *onion* *carrot* *potato* *arrow*))

(objects obj-list) 

(warn "please run (onion-wash)~%")
(warn "you can also run (now-devel)~%")

(defun onion-wash ()
  ;; water point
  (send *onion* :move-to (send *water-point* :copy-worldcoords) :world)
  (send *onion* :copy-worldcoords)
  (send *irtviewer* :look-all
	(geo::make-bounding-box
	 (flatten (send-all (send *onion* :bodies) :vertices))))
  (unix:usleep 1000000)

  ;; on water
  (objects (append obj-list (list *water*)))
  (send *irtviewer* :look-all
	(geo::make-bounding-box
	 (flatten (send-all (append (send *onion* :bodies) (list *water*)) :vertices))))
  (unix:usleep 1000000)

  ;; off water
  (objects obj-list)
  (send *irtviewer* :look-all
	(geo::make-bounding-box
	 (flatten (send-all (append (send *onion* :bodies) (list *water*)) :vertices))))
  (unix:usleep 1000000)

  ;; put on cutting board
  (send *onion* :newcoords (send *cutting-board* :copy-worldcoords))
  (send *onion* :translate #f(0 0 30) :world)
  (send *onion* :copy-worldcoords)
  (send *irtviewer* :look-all
	(geo::make-bounding-box
	 (flatten (send-all (append (send *onion* :bodies) (send *cutting-board* :bodies)) :vertices))))

  (warn "please run (onion-peel)~%")
  )


(defun onion-peel ()
  (send *onion* :cut)
  (send *arrow* :newcoords (send *cut-point-1* :copy-worldcoords))
  (objects obj-list)
  (send *irtviewer* :look-all
	(geo::make-bounding-box
	 (flatten (send-all (append (send *onion* :bodies) (send *cutting-board* :bodies)) :vertices))))
  (unix:usleep 1000000)

  ;; f-cut-1 
  (send o3-1 :dissoc o4-1)
  (send o4-1 :translate #f(0 -40 0) :world)
  (send *irtviewer* :look-all
	(geo::make-bounding-box
	 (flatten (send-all (append (send *onion* :bodies) (send *cutting-board* :bodies)) :vertices))))
  (unix:usleep 1000000)

  ;; set-move 
  (send *arrow* :newcoords (make-coords :pos #f(710 100 840) :rpy #f(1.571 0 1.571)))
  (send o3-1 :move-to (send *arrow* :copy-worldcoords) :world)
  (send *irtviewer* :look-all
	(geo::make-bounding-box
	 (flatten (send-all (append (send *onion* :bodies) (send *cutting-board* :bodies)) :vertices))))
  (unix:usleep 1000000)

  ;; set-move
  (send *arrow* :newcoords (make-coords :pos #f(650 0 840) :rpy #f(0 0 -1.571)))
  (send o4-1 :move-to (send *arrow* :copy-worldcoords) :world)
  (send *arrow* :newcoords (send *cut-point-3* :copy-worldcoords))
  (send *irtviewer* :look-all
	(geo::make-bounding-box
	 (flatten (send-all (append (send *onion* :bodies) (send *cutting-board* :bodies)) :vertices))))
  (unix:usleep 1000000)

  ;; f-cut-2
  (send o4-1 :dissoc o6-1)
  (send o6-1 :translate #f(0 -30 0) :world)
  (send *irtviewer* :look-all
	(geo::make-bounding-box
	 (flatten (send-all (append (send *onion* :bodies) (send *cutting-board* :bodies)) :vertices))))
  (unix:usleep 1000000)

  ;; set-move
  (send o4-1 :rotate (deg2rad 180) :z :world)
  (send o4-1 :copy-worldcoords)
  (send *arrow* :newcoords (send *cut-point-2* :copy-worldcoords))
  (send *irtviewer* :look-all
	(geo::make-bounding-box
	 (flatten (send-all (append (send *onion* :bodies) (send *cutting-board* :bodies)) :vertices))))
  (unix:usleep 1000000)

  ;; f-cut-3
  (send o4-1 :dissoc o2-1)
  (send o2-1 :translate #f(0 -10 0) :world)
  (send o2-1 :copy-worldcoords)
  (send *irtviewer* :look-all
	(geo::make-bounding-box
	 (flatten (send-all (append (send *onion* :bodies) (send *cutting-board* :bodies)) :vertices))))
  (unix:usleep 1000000)
  
  ;; set-move
  (send o6-1 :move-to (send *trash-point* :copy-worldcoords) :world)
  (send o2-1 :move-to (send *trash-point* :copy-worldcoords) :world)
  (send o2-1 :copy-worldcoords)
  (send o6-1 :copy-worldcoords)
  (send *irtviewer* :look-all
	(geo::make-bounding-box
	 (flatten (send-all (append (send *onion* :bodies) (send *cutting-board* :bodies)) :vertices))))
  (unix:usleep 1000000)

  ;; peel
  (send o4-1 :dissoc o4-2)
  (send o4-2 :move-to (send *trash-point* :copy-worldcoords) :world)
  (send o4-2 :copy-worldcoords)
  (send *irtviewer* :look-all
	(geo::make-bounding-box
	 (flatten (send-all (append (send *onion* :bodies) (send *cutting-board* :bodies)) :vertices))))
  (unix:usleep 1000000)

  ;; set-move
  (send *arrow* :newcoords (make-coords :pos #f(710 -100 840) :rpy #f(-1.571 0 -1.571)))
  (send o4-1 :move-to (send *arrow* :copy-worldcoords) :world)
  (send *irtviewer* :look-all
	(geo::make-bounding-box
	 (flatten (send-all (append (send *onion* :bodies) (send *cutting-board* :bodies)) :vertices))))
  (unix:usleep 1000000)

  ;; set-move
  (send *arrow* :newcoords (make-coords :pos #f(650 0 840) :rpy #f(0 0 1.571)))
  (send o3-1 :move-to (send *arrow* :copy-worldcoords) :world)
  (send *arrow* :newcoords (send *cut-point-4* :copy-worldcoords))
  (send *irtviewer* :look-all
	(geo::make-bounding-box
	 (flatten (send-all (append (send *onion* :bodies) (send *cutting-board* :bodies)) :vertices))))
  (unix:usleep 1000000)

  ;; f-cut-4
  (send o3-1 :dissoc o1-1)
  (send o1-1 :translate #f(0 -30 0) :world)
  (send o1-1 :copy-worldcoords)
  (send *irtviewer* :look-all
	(geo::make-bounding-box
	 (flatten (send-all (append (send *onion* :bodies) (send *cutting-board* :bodies)) :vertices))))
  (unix:usleep 1000000)

  ;; set-move
  (send o3-1 :rotate (deg2rad 180) :z :world)
  (send o3-1 :copy-worldcoords)
  (send *arrow* :newcoords (send *cut-point-5* :copy-worldcoords))
  (send *irtviewer* :look-all
	(geo::make-bounding-box
	 (flatten (send-all (append (send *onion* :bodies) (send *cutting-board* :bodies)) :vertices))))
  (unix:usleep 1000000)

  ;; f-cut-5
  (send o3-1 :dissoc o5-1)
  (send o5-1 :translate #f(0 -10 0) :world)
  (send o5-1 :copy-worldcoords)
  (send *irtviewer* :look-all
	(geo::make-bounding-box
	 (flatten (send-all (append (send *onion* :bodies) (send *cutting-board* :bodies)) :vertices))))
  (unix:usleep 1000000)

  ;; set-move
  (send o5-1 :move-to (send *trash-point* :copy-worldcoords) :world)
  (send o1-1 :move-to (send *trash-point* :copy-worldcoords) :world)
  (send o5-1 :copy-worldcoords)
  (send o1-1 :copy-worldcoords)
  (send *irtviewer* :look-all
	(geo::make-bounding-box
	 (flatten (send-all (append (send *onion* :bodies) (send *cutting-board* :bodies)) :vertices))))
  (unix:usleep 1000000)

  ;; peel
  (send o3-1 :dissoc o3-2)
  (send o3-2 :move-to (send *trash-point* :copy-worldcoords) :world)
  (send o3-2 :copy-worldcoords)
  (send *irtviewer* :look-all
	(geo::make-bounding-box
	 (flatten (send-all (append (send *onion* :bodies) (send *cutting-board* :bodies)) :vertices))))
  (unix:usleep 1000000)

  (warn "please run (onion-cut)~%")  
  )

(defun onion-cut ()
  ;; set-move
  (send *arrow* :newcoords (make-coords :pos #f(680 0 840) :rpy #f(1.571 0 1.571)))
  (send o3-1 :move-to (send *arrow* :copy-worldcoords) :world)
  (send o3-1 :copy-worldcoords)
  (send *arrow* :newcoords (make-coords :pos #f(620 0 840) :rpy #f(-1.571 0 -1.571)))
  (send o4-1 :move-to (send *arrow* :copy-worldcoords) :world)
  (send o4-1 :copy-worldcoords)
  (send *irtviewer* :look-all
	(geo::make-bounding-box
	 (flatten (send-all (append (send *onion* :bodies) (send *cutting-board* :bodies)) :vertices))))
  (unix:usleep 1000000)

  ;; cut-1
  (send o3-1 :dissoc o3-3-1)
  (send o3-1 :dissoc o3-3-2)
  (send o3-1 :dissoc o3-3-3)
  (send o3-1 :dissoc o3-3-4)
  (send o3-1 :dissoc o3-3-5)
  (send o3-1 :dissoc o3-3-6)
  (send o3-1 :dissoc o3-3-7)
  (send o3-1 :dissoc o3-3-8)
  (send o3-1 :locate #f(-20 0 0))
  (send o3-3-8 :locate #f(-15 0 0))
  (send o3-3-7 :locate #f(-10 0 0))
  (send o3-3-6 :locate #f(-5 0 0))
  (send o3-3-5 :locate #f(0 0 0))
  (send o3-3-4 :locate #f(5 0 0))
  (send o3-3-3 :locate #f(10 0 0))
  (send o3-3-2 :locate #f(15 0 0))
  (send o3-3-1 :locate #f(20 0 0))  
  (send *viewer* :draw-objects)
  (unix:usleep 1000000)

  (send o4-1 :dissoc o4-3-1)
  (send o4-1 :dissoc o4-3-2)
  (send o4-1 :dissoc o4-3-3)
  (send o4-1 :dissoc o4-3-4)
  (send o4-1 :dissoc o4-3-5)
  (send o4-1 :dissoc o4-3-6)
  (send o4-1 :dissoc o4-3-7)
  (send o4-1 :dissoc o4-3-8)
  (send o4-1 :locate #f(-20 0 0))
  (send o4-3-8 :locate #f(-15 0 0))
  (send o4-3-7 :locate #f(-10 0 0))
  (send o4-3-6 :locate #f(-5 0 0))
  (send o4-3-5 :locate #f(0 0 0))
  (send o4-3-4 :locate #f(5 0 0))
  (send o4-3-3 :locate #f(10 0 0))
  (send o4-3-2 :locate #f(15 0 0))
  (send o4-3-1 :locate #f(20 0 0))
  (send *viewer* :draw-objects)
  (unix:usleep 1000000)

  ;; set-move
  (send o3-1 :assoc o3-3-1)
  (send o3-1 :assoc o3-3-2)
  (send o3-1 :assoc o3-3-3)
  (send o3-1 :assoc o3-3-4)
  (send o3-1 :assoc o3-3-5)
  (send o3-1 :assoc o3-3-6)
  (send o3-1 :assoc o3-3-7)
  (send o3-1 :assoc o3-3-8)
  (send o4-1 :assoc o4-3-1)
  (send o4-1 :assoc o4-3-2)
  (send o4-1 :assoc o4-3-3)
  (send o4-1 :assoc o4-3-4)
  (send o4-1 :assoc o4-3-5)
  (send o4-1 :assoc o4-3-6)
  (send o4-1 :assoc o4-3-7)
  (send o4-1 :assoc o4-3-8)

  (send o3-1 :move-to (make-coords :pos #f(900 200 835) :rpy #f(1.571 0 1.571)) :world)
  (send o4-1 :move-to (make-coords :pos #f(850 240 835) :rpy #f(-1.571 0 -1.571)) :world)
  (send *irtviewer* :look-all
	(geo::make-bounding-box
	 (flatten (send-all (append (send *onion* :bodies) (send *cutting-board* :bodies)) :vertices))))
  (send *viewer* :draw-objects)
  (unix:usleep 1000000)

  (warn "please run (carrot-wash)~%")    
  )

(defun carrot-wash ()
  ;; water point
  (send *carrot* :move-to (send *water-point* :copy-worldcoords) :world)
  (send *carrot* :rotate (deg2rad -90) :z :world)
  (send *carrot* :copy-worldcoords)
  (send *irtviewer* :look-all
	(geo::make-bounding-box
	 (flatten (send-all (send *carrot* :bodies) :vertices))))
  (unix:usleep 1000000)

  ;; on water
  (objects (append obj-list (list *water*)))
  (send *irtviewer* :look-all
	(geo::make-bounding-box
	 (flatten (send-all (append (send *carrot* :bodies) (list *water*)) :vertices))))
  (unix:usleep 1000000)

  ;; off water
  (objects obj-list)
  (send *irtviewer* :look-all
	(geo::make-bounding-box
	 (flatten (send-all (append (send *carrot* :bodies) (list *water*)) :vertices))))
  (unix:usleep 1000000)

  ;; put on cutting board
  (send *carrot* :newcoords (send *cutting-board* :copy-worldcoords))
  (send *carrot* :translate #f(0 0 30) :world)
  (send *carrot* :rotate (deg2rad -90) :z :world)
  (send *carrot* :copy-worldcoords)
  (send *irtviewer* :look-all
	(geo::make-bounding-box
	 (flatten (send-all (append (send *carrot* :bodies) (send *cutting-board* :bodies)) :vertices))))

  (warn "please run (carrot-peel)~%")
  )
  
(defun carrot-peel ()
  (send *carrot* :cut)
  (send *arrow* :newcoords (send *cut-point-1* :copy-worldcoords))
  (objects obj-list)
  (send *irtviewer* :look-all
	(geo::make-bounding-box
	 (flatten (send-all (append (send *carrot* :bodies) (send *cutting-board* :bodies)) :vertices))))
  (unix:usleep 1000000)

  ;; f-cut-1 
  (send c2-1-1 :dissoc c1)
  (send c1 :translate #f(0 -30 0) :world)
  (send c1 :copy-worldcoords)
  (send *irtviewer* :look-all
	(geo::make-bounding-box
	 (flatten (send-all (append (send *carrot* :bodies) (send *cutting-board* :bodies)) :vertices))))
  (unix:usleep 1000000)

  ;; set-move
  (send *arrow* :newcoords (send *cut-point-2* :copy-worldcoords))
  (send *irtviewer* :look-all
	(geo::make-bounding-box
	 (flatten (send-all (append (send *carrot* :bodies) (send *cutting-board* :bodies)) :vertices))))
  (unix:usleep 1000000)

  ;; f-cut-2
  (send c2-1-1 :dissoc c3-1-1)
  (send c2-1-1 :translate #f(0 -20 0) :world)
  (send c2-1-1 :copy-worldcoords)
  (send *irtviewer* :look-all
	(geo::make-bounding-box
	 (flatten (send-all (append (send *carrot* :bodies) (send *cutting-board* :bodies)) :vertices))))
  (unix:usleep 1000000)

  ;; set-move
  (send c1 :move-to (send *trash-point* :copy-worldcoords) :world)
  (send c1 :copy-worldcoords)
  (send *irtviewer* :look-all
	(geo::make-bounding-box
	 (flatten (send-all (append (send *carrot* :bodies) (send *cutting-board* :bodies)) :vertices))))
  (unix:usleep 1000000)

  (send c3-1-1 :move-to (make-coords :pos #f(900 0 845)) :world)
  (send c3-1-1 :copy-worldcoords)
  (send *arrow* :newcoords (send *cut-point-4* :copy-worldcoords))
  (send *irtviewer* :look-all
	(geo::make-bounding-box
	 (flatten (send-all (append (send *carrot* :bodies) (send *cutting-board* :bodies)) :vertices))))
  (unix:usleep 1000000)
  
  (warn "please run (carrot-cut)~%")
  )

(defun carrot-cut ()
  ;; cut-1
  (send c2-1-1 :dissoc c2-2-1)
  (send c2-1-1 :translate #f(0 -20 0))
  (send *viewer* :draw-objects)
  (unix:usleep 1000000)

  ;; set-move
  (send *arrow* :newcoords (make-coords :pos #f(690 60 840) :rpy #f(-1.571 0 -1.571)))
  (send c2-1-1 :move-to (send *arrow* :copy-worldcoords) :world)
  (send c2-1-1 :copy-worldcoords)
  (send *arrow* :newcoords (make-coords :pos #f(610 60 840) :rpy #f(-1.571 0 1.571)))
  (send c2-2-1 :move-to (send *arrow* :copy-worldcoords) :world)
  (send c2-2-1 :copy-worldcoords)
  (send *irtviewer* :look-all
	(geo::make-bounding-box
	 (flatten (send-all (append (send *carrot* :bodies) (send *cutting-board* :bodies)) :vertices))))
  (unix:usleep 1000000)

  ;; cut-2
  (send c2-1-1 :dissoc c2-1-2)
  (send c2-1-1 :dissoc c2-1-3)
  (send c2-1-1 :dissoc c2-1-4)
  (send c2-1-1 :dissoc c2-1-5)
  (send c2-1-1 :dissoc c2-1-6)
  (send c2-1-1 :dissoc c2-1-7)
  (send c2-1-1 :locate #f(-15 0 0))
  (send c2-1-2 :locate #f(-10 0 0))
  (send c2-1-3 :locate #f(-5 0 0))
  (send c2-1-4 :locate #f(0 0 0))
  (send c2-1-5 :locate #f(5 0 0))
  (send c2-1-6 :locate #f(10 0 0))
  (send c2-1-7 :locate #f(15 0 0))
  (send *viewer* :draw-objects)
  (unix:usleep 1000000)

  (send c2-2-1 :dissoc c2-2-2)
  (send c2-2-1 :dissoc c2-2-3)
  (send c2-2-1 :dissoc c2-2-4)
  (send c2-2-1 :dissoc c2-2-5)
  (send c2-2-1 :dissoc c2-2-6)
  (send c2-2-1 :dissoc c2-2-7)
  (send c2-2-1 :locate #f(-15 0 0))
  (send c2-2-2 :locate #f(-10 0 0))
  (send c2-2-3 :locate #f(-5 0 0))
  (send c2-2-4 :locate #f(0 0 0))
  (send c2-2-5 :locate #f(5 0 0))
  (send c2-2-6 :locate #f(10 0 0))
  (send c2-2-7 :locate #f(15 0 0))
  (send *viewer* :draw-objects)
  (unix:usleep 1000000)

  ;; set-move
  (send c2-1-1 :assoc c2-1-2)
  (send c2-1-1 :assoc c2-1-3)
  (send c2-1-1 :assoc c2-1-4)
  (send c2-1-1 :assoc c2-1-5)
  (send c2-1-1 :assoc c2-1-6)
  (send c2-1-1 :assoc c2-1-7)
  (send c2-2-1 :assoc c2-2-2)
  (send c2-2-1 :assoc c2-2-3)
  (send c2-2-1 :assoc c2-2-4)
  (send c2-2-1 :assoc c2-2-5)
  (send c2-2-1 :assoc c2-2-6)
  (send c2-2-1 :assoc c2-2-7)
  (send c2-1-1 :move-to (make-coords :pos #f(760 330 835) :rpy #f(-1.571 0 -1.571)) :world)
  (send c2-2-1 :move-to (make-coords :pos #f(700 330 835) :rpy #f(-1.571 0 1.571)) :world)
  (send *irtviewer* :look-all
	(geo::make-bounding-box
	 (flatten (send-all (append (send *carrot* :bodies) (send *cutting-board* :bodies)) :vertices))))
  (send *viewer* :draw-objects)
  (unix:usleep 1000000)

  (warn "please run (potato-wash)~%")  
  )

(defun potato-wash ()
  ;; water point
  (send *potato* :move-to (send *water-point* :copy-worldcoords) :world)
  (send *potato* :rotate (deg2rad -90) :z :world)
  (send *potato* :copy-worldcoords)
  (send *irtviewer* :look-all
	(geo::make-bounding-box
	 (flatten (send-all (send *potato* :bodies) :vertices))))
  (unix:usleep 1000000)

  ;; on water
  (objects (append obj-list (list *water*)))
  (send *irtviewer* :look-all
	(geo::make-bounding-box
	 (flatten (send-all (append (send *potato* :bodies) (list *water*)) :vertices))))
  (unix:usleep 1000000)

  ;; off water
  (objects obj-list)
  (send *irtviewer* :look-all
	(geo::make-bounding-box
	 (flatten (send-all (append (send *potato* :bodies) (list *water*)) :vertices))))
  (unix:usleep 1000000)

  ;; put on cutting board
  (send *potato* :newcoords (send *cutting-board* :copy-worldcoords))
  (send *potato* :translate #f(0 0 30) :world)
  (send *potato* :rotate (deg2rad -90) :z :world)
  (send *potato* :copy-worldcoords)
  (send *irtviewer* :look-all
	(geo::make-bounding-box
	 (flatten (send-all (append (send *potato* :bodies) (send *cutting-board* :bodies)) :vertices))))

  (warn "please run (potato-peel)~%")
  )


(defun potato-peel ()
  (send *potato* :peel)
  (objects obj-list)
  (send *irtviewer* :look-all
	(geo::make-bounding-box
	 (flatten (send-all (append (send *potato* :bodies) (send *cutting-board* :bodies)) :vertices))))
  (unix:usleep 1000000)

  ;; peel-1
  (send p1 :set-color :moccasin)
  (send *viewer* :draw-objects)
  (unix:usleep 1000000)

  ;; set-move
  (send *potato* :rotate (deg2rad 90) :x)
  (send *viewer* :draw-objects)
  (unix:usleep 1000000)

  ;; peel-2
  (send p2 :set-color :moccasin)
  (send *viewer* :draw-objects)
  (unix:usleep 1000000)
  
  ;; set-move
  (send *potato* :rotate (deg2rad 90) :x)
  (send *viewer* :draw-objects)
  (unix:usleep 1000000)

  ;; peel-3
  (send p3 :set-color :moccasin)
  (send *viewer* :draw-objects)
  (unix:usleep 1000000)

    ;; set-move
  (send *potato* :rotate (deg2rad 90) :x)
  (send *viewer* :draw-objects)
  (unix:usleep 1000000)

  ;; peel-4
  (send p4 :set-color :moccasin)
  (send *viewer* :draw-objects)
  (unix:usleep 1000000)

  ;; set-move
  (send *potato* :rotate (deg2rad 90) :x)
  (send *viewer* :draw-objects)
  (unix:usleep 1000000)
  
  (warn "please run (potato-cut)~%")
  )

(defun potato-cut ()
  (send *potato* :cut)
  (send *arrow* :newcoords (send *cut-point-1* :copy-worldcoords))
  (objects obj-list)
    (send *irtviewer* :look-all
	(geo::make-bounding-box
	 (flatten (send-all (append (send *potato* :bodies) (send *cutting-board* :bodies)) :vertices))))
  (unix:usleep 1000000)

  ;; cut-1
  (send p4 :dissoc p1)
  (send p4 :dissoc p2)
  (send p4 :dissoc p3)
  (send p1 :assoc p2)
  (send p1 :assoc p3)
  (setq *potato2* (make-cascoords))
  (send *potato2* :newcoords (send *potato* :copy-worldcoords))
  (send *potato2* :assoc p1)
  (send *potato2* :translate #f(0 -30 0) :world)
  (send *viewer* :draw-objects)
  (unix:usleep 1000000)

  ;; set-move
  (send *arrow* :newcoords (make-coords :pos #f(710 100 840) :rpy #f(0.785 1.571 -0.785)))
  (send *potato* :move-to (send *arrow* :copy-worldcoords) :world)
  (send *viewer* :draw-objects)
  (unix:usleep 1000000)

  (send *arrow* :newcoords (make-coords :pos #f(650 -60 840) :rpy #f(0.785 -1.571 -2.357)))
  (send *potato2* :move-to (send *arrow* :copy-worldcoords) :world)
  (send *arrow* :newcoords (send *cut-point-2* :copy-worldcoords))
  (send *viewer* :draw-objects)
  (unix:usleep 1000000)

  ;; cut-2
  (send *potato2* :dissoc p3)
  (send p3 :translate #f(0 -20 0) :world)
  (send *viewer* :draw-objects)
  (unix:usleep 1000000)

  ;; set-move
  (send *arrow* :newcoords (send *cut-point-3* :copy-worldcoords))
  (send *viewer* :draw-objects)
  (unix:usleep 1000000)

  ;; cut-3
  (send *potato2* :dissoc p2)
  (send p2 :translate #f(0 -10 0) :world)
  (send *viewer* :draw-objects)
  (unix:usleep 1000000)

  ;; set-move
  (send *arrow* :newcoords (make-coords :pos #f(650 60 840) :rpy #f(0.785 1.571 -0.785)))
  (send *potato* :move-to (send *arrow* :copy-worldcoords) :world)
  (send *arrow* :newcoords (send *cut-point-4* :copy-worldcoords))
  (send *viewer* :draw-objects)
  (unix:usleep 1000000)

  ;; cut-4
  (send *potato* :dissoc p6)
  (send p6 :translate #f(0 -20 0) :world)
  (send *viewer* :draw-objects)
  (unix:usleep 1000000)

  ;; set-move
  (send *arrow* :newcoords (send *cut-point-5* :copy-worldcoords))
  (send *viewer* :draw-objects)
  (unix:usleep 1000000)

  ;; cut-5
  (send *potato* :dissoc p5)
  (send p5 :translate #f(0 -10 0) :world)
  (send *viewer* :draw-objects)
  (unix:usleep 1000000)
  
  )
  

  


(defun now-devel ()
  (onion-wash)
  (onion-peel)
  (onion-cut)
  (carrot-wash)
  (carrot-peel)
  (carrot-cut)  
  (potato-wash)
  (potato-peel)
  (potato-cut)
  )
  
  

(defun carrot-test ()
  (carrot-wash)
  (carrot-peel)
  (carrot-cut)
  )

(defun potato-test ()
  (potato-wash)
  (potato-peel)
  (potato-cut)
  )
