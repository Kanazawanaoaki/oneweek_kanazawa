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
(setq *water-point* (make-coords :pos #f(770 -600 830)))
(setq *trash-point* (make-coords :pos #f(880 -270 835)))

;; set water
(setq *water* (make-cylinder 15 100))
(send *water* :set-color :cyan)
(send *water* :move-to (send *water-point* :copy-worldcoords) :world)

(setq obj-list (list *kitchen* *knife* *peeler* *cutting-board* *pot* *onion* *carrot* *potato* *arrow*))

(objects obj-list) 

(warn "please run (onion-wash)~%")

(defun onion-wash ()
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

  (send *onion* :newcoords (send *cutting-board* :copy-worldcoords))
  (send *onion* :translate #f(0 0 30) :world)
  (send *onion* :copy-worldcoords)
  (send *irtviewer* :look-all
	(geo::make-bounding-box
	 (flatten (send-all (append (send *onion* :bodies) (send *cutting-board* :bodies)) :vertices))))

  (warn "please run (onion-f-cut)~%")
  )


(defun onion-f-cut ()
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
  (send *irtviewer* :look-all
	(geo::make-bounding-box
	 (flatten (send-all (append (send *onion* :bodies) (send *cutting-board* :bodies)) :vertices))))
  (unix:usleep 1000000)

  ;; set-move
  (send *arrow* :newcoords (make-coords :pos #f(710 -100 840) :rpy #f(1.571 0 -1.571)))
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

  )




(defun now-devel ()
  (onion-wash)
  (onion-f-cut)
  
  )
  
  

