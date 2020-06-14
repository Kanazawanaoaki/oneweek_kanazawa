(defun init ()

  ;; set kitchen
  (load "models/room73b2-kitchen-object.l")
  (setq *kitchen* (room73b2-kitchen))
  (send *kitchen* :locate #f(800 -200 0))
  (send *kitchen* :rotate (deg2rad 180) :z :world)

  ;; set knife
  (load "models/knife-object.l")
  (setq *knife* (knife))
  (send *knife* :locate #f(550.0 -200.0 850.0))

  ;; set pan
  (load "models/frying-pan-object.l")
  (setq *pan* (frying-pan))
  (send *pan* :locate #f(680 770 860))

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
  (send *onion* :locate #f(860 150 845))

  ;; set carrot
  (load "model/carrot-test-model.l")
  (setq *carrot* (carrot))
  (send *carrot* :locate #f(900 50 845))

  ;; set potato
  (load "model/potato-test-model.l")
  (setq *potato* (potato))
  (send *potato* :locate #f(860 -50 845))

  ;; set niku
  (load "model/niku-test.l")
  (setq *niku* (niku))
  (send *niku* :locate #f(980 -130 845))

  ;; set trash-box
  (load "model/trash-box.l")
  (setq *trash-box* (trash-box))
  (send *trash-box* :locate #f(800 -290 830))

  ;; set mcup
  (load "model/measuring-cup.l")
  (setq *mcup* (measuring-cup))
  (send *mcup* :locate #f(980 -330 845))

  ;; set roux
  (load "model/roux-test.l")
  (setq *roux* (roux))
  (send *roux* :locate #f(980 180 845))
  
  ;; set arrow
  (load "models/arrow-object.l")
  (setq *arrow* (arrow))

  ;; set spots
  (setq *sink-spot* (make-coords :pos #f(0 -600 0)))
  (setq *kitchen-spot* (make-coords :pos #f(0 0 0)))

  ;; set points
  (setq *water-point* (make-coords :pos #f(770 -605 830)))
  (setq *trash-point* (make-coords :pos #f(800 -290 837)))

  ;; set water
  (setq *water* (make-cylinder 15 100))
  (send *water* :set-color :cyan 0.5)
  (send *water* :move-to (send *water-point* :copy-worldcoords) :world)


  ;;defin object list for visialize
  (setq obj-list (list *kitchen* *knife* *peeler* *cutting-board* *pot* *pan* *onion* *carrot* *potato* *niku* *trash-box* *mcup* *roux*))
  ;; (setq obj-list (list *kitchen* *knife* *peeler* *cutting-board* *pot* *pan* *onion* *carrot* *potato* *niku* *trash-box* *mcup* *roux* *arrow*))

  (objects obj-list)
  )

(init)

(send *onion* :cut)

;; set sleep time
(setq s-time 1000000)
;; (setq s-time 500000)

(warn "please run (onion-wash)~%")
(warn "you can also run (now-devel) or (exec-all)~%")

(defun onion-wash ()
  ;; water point
  (send *onion* :move-to (send *water-point* :copy-worldcoords) :world)
  (send *onion* :copy-worldcoords)
  (send *irtviewer* :look-all
	(geo::make-bounding-box
	 (flatten (send-all (send *onion* :bodies) :vertices))))
  (unix:usleep s-time)

  ;; on water
  (objects (append obj-list (list *water*)))
  (send *irtviewer* :look-all
	(geo::make-bounding-box
	 (flatten (send-all (append (send *onion* :bodies) (list *water*)) :vertices))))
  (unix:usleep s-time)

  ;; off water
  (objects obj-list)
  (send *irtviewer* :look-all
	(geo::make-bounding-box
	 (flatten (send-all (append (send *onion* :bodies) (list *water*)) :vertices))))
  (unix:usleep s-time)

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
  (if (not (boundp 'o3-3-1))
      (send *onion* :cut))
  (setq *o-list* (list o3-1 o3-3-1 o3-3-2 o3-3-3 o3-3-4 o3-3-5 o3-3-6 o3-3-7 o3-3-8 o4-1 o4-3-1 o4-3-2 o4-3-3 o4-3-4 o4-3-5 o4-3-6 o4-3-7 o4-3-8))
  (send *arrow* :newcoords (send *cut-point-1* :copy-worldcoords))
  (objects obj-list)
  (send *irtviewer* :look-all
	(geo::make-bounding-box
	 (flatten (send-all (append (send *onion* :bodies) (send *cutting-board* :bodies)) :vertices))))
  (unix:usleep s-time)

  ;; f-cut-1 
  (send o3-1 :dissoc o4-1)
  (send o4-1 :translate #f(0 -40 0) :world)
  (send *irtviewer* :look-all
	(geo::make-bounding-box
	 (flatten (send-all (append (send *onion* :bodies) (send *cutting-board* :bodies)) :vertices))))
  (unix:usleep s-time)

  ;; set-move 
  (send *arrow* :newcoords (make-coords :pos #f(710 100 840) :rpy #f(1.571 0 1.571)))
  (send o3-1 :move-to (send *arrow* :copy-worldcoords) :world)
  (send *viewer* :draw-objects)
  (unix:usleep s-time)

  ;; set-move
  (send *arrow* :newcoords (make-coords :pos #f(650 0 840) :rpy #f(0 0 -1.571)))
  (send o4-1 :move-to (send *arrow* :copy-worldcoords) :world)
  (send *arrow* :newcoords (send *cut-point-3* :copy-worldcoords))
  (send *viewer* :draw-objects)
  (unix:usleep s-time)

  ;; f-cut-2
  (send o4-1 :dissoc o6-1)
  (send o6-1 :translate #f(0 -30 0) :world)
  (send *viewer* :draw-objects)
  (unix:usleep s-time)

  ;; set-move
  (send o4-1 :rotate (deg2rad 180) :z :world)
  (send o4-1 :copy-worldcoords)
  (send *arrow* :newcoords (send *cut-point-2* :copy-worldcoords))
  (send *viewer* :draw-objects)
  (unix:usleep s-time)

  ;; f-cut-3
  (send o4-1 :dissoc o2-1)
  (send o2-1 :translate #f(0 -10 0) :world)
  (send o2-1 :copy-worldcoords)
  (send *viewer* :draw-objects)
  (unix:usleep s-time)
  
  ;; set-move
  (send o6-1 :move-to (send *trash-point* :copy-worldcoords) :world)
  (send o2-1 :move-to (send *trash-point* :copy-worldcoords) :world)
  (send o2-1 :copy-worldcoords)
  (send o6-1 :copy-worldcoords)
  (send *irtviewer* :look-all
	(geo::make-bounding-box
	 (flatten (send-all (append (send *onion* :bodies) (send *cutting-board* :bodies)) :vertices))))
  (unix:usleep s-time)

  ;; peel
  (send o4-1 :dissoc o4-2)
  (send o4-2 :move-to (send *trash-point* :copy-worldcoords) :world)
  (send o4-2 :copy-worldcoords)
  (send *irtviewer* :look-all
	(geo::make-bounding-box
	 (flatten (send-all (append (send *onion* :bodies) (send *cutting-board* :bodies)) :vertices))))
  (unix:usleep s-time)

  ;; set-move
  (send *arrow* :newcoords (make-coords :pos #f(710 -100 840) :rpy #f(-1.571 0 -1.571)))
  (send o4-1 :move-to (send *arrow* :copy-worldcoords) :world)
  (send *irtviewer* :look-all
	(geo::make-bounding-box
	 (flatten (send-all (append (send *onion* :bodies) (send *cutting-board* :bodies)) :vertices))))
  (unix:usleep s-time)

  ;; set-move
  (send *arrow* :newcoords (make-coords :pos #f(650 0 840) :rpy #f(0 0 1.571)))
  (send o3-1 :move-to (send *arrow* :copy-worldcoords) :world)
  (send *arrow* :newcoords (send *cut-point-4* :copy-worldcoords))
  (send *viewer* :draw-objects)
  (unix:usleep s-time)

  ;; f-cut-4
  (send o3-1 :dissoc o1-1)
  (send o1-1 :translate #f(0 -30 0) :world)
  (send o1-1 :copy-worldcoords)
  (send *viewer* :draw-objects)
  (unix:usleep s-time)

  ;; set-move
  (send o3-1 :rotate (deg2rad 180) :z :world)
  (send o3-1 :copy-worldcoords)
  (send *arrow* :newcoords (send *cut-point-5* :copy-worldcoords))
  (send *viewer* :draw-objects)
  (unix:usleep s-time)

  ;; f-cut-5
  (send o3-1 :dissoc o5-1)
  (send o5-1 :translate #f(0 -10 0) :world)
  (send o5-1 :copy-worldcoords)
  (send *viewer* :draw-objects)
  (unix:usleep s-time)

  ;; set-move
  (send o5-1 :move-to (send *trash-point* :copy-worldcoords) :world)
  (send o1-1 :move-to (send *trash-point* :copy-worldcoords) :world)
  (send o5-1 :copy-worldcoords)
  (send o1-1 :copy-worldcoords)
  (send *irtviewer* :look-all
	(geo::make-bounding-box
	 (flatten (send-all (append (send *onion* :bodies) (send *cutting-board* :bodies)) :vertices))))
  (unix:usleep s-time)

  ;; peel
  (send o3-1 :dissoc o3-2)
  (send o3-2 :move-to (send *trash-point* :copy-worldcoords) :world)
  (send o3-2 :copy-worldcoords)
  (send *irtviewer* :look-all
	(geo::make-bounding-box
	 (flatten (send-all (append (send *onion* :bodies) (send *cutting-board* :bodies)) :vertices))))
  (unix:usleep s-time)

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
  (unix:usleep s-time)

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
  (unix:usleep s-time)

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
  (unix:usleep s-time)

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
  (unix:usleep s-time)

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
  (unix:usleep s-time)

  ;; on water
  (objects (append obj-list (list *water*)))
  (send *irtviewer* :look-all
	(geo::make-bounding-box
	 (flatten (send-all (append (send *carrot* :bodies) (list *water*)) :vertices))))
  (unix:usleep s-time)

  ;; off water
  (objects obj-list)
  (send *irtviewer* :look-all
	(geo::make-bounding-box
	 (flatten (send-all (append (send *carrot* :bodies) (list *water*)) :vertices))))
  (unix:usleep s-time)

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
  (unix:usleep s-time)

  ;; f-cut-1 
  (send c2-1-1 :dissoc c1)
  (send c1 :translate #f(0 -30 0) :world)
  (send c1 :copy-worldcoords)
  (send *viewer* :draw-objects)
  (unix:usleep s-time)

  ;; set-move
  (send *arrow* :newcoords (send *cut-point-2* :copy-worldcoords))
  (send *viewer* :draw-objects)
  
  ;; f-cut-2
  (send c2-1-1 :dissoc c3-1-1)
  (send c2-1-1 :translate #f(0 -20 0) :world)
  (send c2-1-1 :copy-worldcoords)
  (send *irtviewer* :look-all
	(geo::make-bounding-box
	 (flatten (send-all (append (send *carrot* :bodies) (send *cutting-board* :bodies)) :vertices))))
  (unix:usleep s-time)

  ;; set-move
  (send c1 :move-to (send *trash-point* :copy-worldcoords) :world)
  (send c1 :translate #f(-80 0 0) :world)
  (send c1 :copy-worldcoords)
  (send *irtviewer* :look-all
	(geo::make-bounding-box
	 (flatten (send-all (append (send *carrot* :bodies) (send *cutting-board* :bodies)) :vertices))))
  (unix:usleep s-time)

  (send c3-1-1 :move-to (make-coords :pos #f(900 0 845)) :world)
  (send c3-1-1 :copy-worldcoords)
  (send *arrow* :newcoords (send *cut-point-4* :copy-worldcoords))
  (send *irtviewer* :look-all
	(geo::make-bounding-box
	 (flatten (send-all (append (send *carrot* :bodies) (send *cutting-board* :bodies)) :vertices))))
  (unix:usleep s-time)
  
  (warn "please run (carrot-cut)~%")
  )

(defun carrot-cut ()
  ;; cut-1
  (send c2-1-1 :dissoc c2-2-1)
  (send c2-1-1 :translate #f(0 -20 0))
  (send *viewer* :draw-objects)
  (unix:usleep s-time)

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
  (unix:usleep s-time)

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
  (unix:usleep s-time)

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
  (unix:usleep s-time)

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
  (unix:usleep s-time)

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
  (unix:usleep s-time)

  ;; on water
  (objects (append obj-list (list *water*)))
  (send *irtviewer* :look-all
	(geo::make-bounding-box
	 (flatten (send-all (append (send *potato* :bodies) (list *water*)) :vertices))))
  (unix:usleep s-time)

  ;; off water
  (objects obj-list)
  (send *irtviewer* :look-all
	(geo::make-bounding-box
	 (flatten (send-all (append (send *potato* :bodies) (list *water*)) :vertices))))
  (unix:usleep s-time)

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
  (unix:usleep s-time)

  ;; peel-1
  (send p1 :set-color :moccasin)
  (send *viewer* :draw-objects)
  (unix:usleep s-time)

  ;; set-move
  (send *potato* :rotate (deg2rad 90) :x)
  (send *viewer* :draw-objects)
  (unix:usleep s-time)

  ;; peel-2
  (send p2 :set-color :moccasin)
  (send *viewer* :draw-objects)
  (unix:usleep s-time)
  
  ;; set-move
  (send *potato* :rotate (deg2rad 90) :x)
  (send *viewer* :draw-objects)
  (unix:usleep s-time)

  ;; peel-3
  (send p3 :set-color :moccasin)
  (send *viewer* :draw-objects)
  (unix:usleep s-time)

    ;; set-move
  (send *potato* :rotate (deg2rad 90) :x)
  (send *viewer* :draw-objects)
  (unix:usleep s-time)

  ;; peel-4
  (send p4 :set-color :moccasin)
  (send *viewer* :draw-objects)
  (unix:usleep s-time)

  ;; set-move
  (send *potato* :rotate (deg2rad 90) :x)
  (send *viewer* :draw-objects)
  (unix:usleep s-time)
  
  (warn "please run (potato-cut)~%")
  )

(defun potato-cut ()
  (send *potato* :cut)
  (send *arrow* :newcoords (send *cut-point-1* :copy-worldcoords))
  (objects obj-list)
  (send *irtviewer* :look-all
	(geo::make-bounding-box
	 (flatten (send-all (append (send *potato* :bodies) (send *cutting-board* :bodies)) :vertices))))
  (unix:usleep s-time)

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
  (unix:usleep s-time)

  ;; set-move
  (send *arrow* :newcoords (make-coords :pos #f(710 100 840) :rpy #f(0.785 1.571 -0.785)))
  (send *potato* :move-to (send *arrow* :copy-worldcoords) :world)
  (send *viewer* :draw-objects)
  (unix:usleep s-time)

  (send *arrow* :newcoords (make-coords :pos #f(650 -60 840) :rpy #f(0.785 -1.571 -2.357)))
  (send *potato2* :move-to (send *arrow* :copy-worldcoords) :world)
  (send *arrow* :newcoords (send *cut-point-2* :copy-worldcoords))
  (send *viewer* :draw-objects)
  (unix:usleep s-time)

  ;; cut-2
  (send *potato2* :dissoc p3)
  (send p3 :translate #f(0 -20 0) :world)
  (send *viewer* :draw-objects)
  (unix:usleep s-time)

  ;; set-move
  (send *arrow* :newcoords (send *cut-point-3* :copy-worldcoords))
  (send *viewer* :draw-objects)

  ;; cut-3
  (send *potato2* :dissoc p2)
  (send p2 :translate #f(0 -10 0) :world)
  (send *viewer* :draw-objects)
  (unix:usleep s-time)

  ;; set-move
  (send *arrow* :newcoords (make-coords :pos #f(650 60 840) :rpy #f(0.785 1.571 -0.785)))
  (send *potato* :move-to (send *arrow* :copy-worldcoords) :world)
  (send *arrow* :newcoords (send *cut-point-4* :copy-worldcoords))
  (send *viewer* :draw-objects)
  (unix:usleep s-time)

  ;; cut-4
  (send *potato* :dissoc p6)
  (send p6 :translate #f(0 -20 0) :world)
  (send *viewer* :draw-objects)
  (unix:usleep s-time)

  ;; set-move
  (send *arrow* :newcoords (send *cut-point-5* :copy-worldcoords))
  (send *viewer* :draw-objects)

  ;; cut-5
  (send *potato* :dissoc p5)
  (send p5 :translate #f(0 -10 0) :world)
  (send *viewer* :draw-objects)
  (unix:usleep s-time)

  (warn "please run (onion-stir-fry)~%")
  )

(defun onion-stir-fry ()
  ;; set-onion
  (send o3-1 :move-to (send *pan* :copy-worldcoords) :world)
  (send o3-1 :rotate (deg2rad -90) :z :world) 
  (send o3-1 :translate #f(30 20 -20) :world)
  (send o3-1 :rotate (deg2rad -90) :y :world) 
  (send o3-1 :copy-worldcoords)
  (send o4-1 :move-to (send *pan* :copy-worldcoords) :world)
  (send o4-1 :rotate (deg2rad -90) :z :world) 
  (send o4-1 :translate #f(-30 20 -20) :world)
  (send o4-1 :rotate (deg2rad 90) :y :world) 
  (send o4-1 :copy-worldcoords)
  (send *irtviewer* :look-all
	(geo::make-bounding-box
	 (flatten (send-all (append *o-list* (send *pan* :bodies)) :vertices))))
  (unix:usleep s-time)


  ;; かき混ぜる
  (setq *o* (make-cascoords))
  (send *o* :newcoords (send o3-1 :copy-worldcoords))
  (send o3-1 :dissoc o3-3-1)
  (send o3-1 :dissoc o3-3-2)
  (send o3-1 :dissoc o3-3-3)
  (send o3-1 :dissoc o3-3-4)
  (send o3-1 :dissoc o3-3-5)
  (send o3-1 :dissoc o3-3-6)
  (send o3-1 :dissoc o3-3-7)
  (send o3-1 :dissoc o3-3-8)
  (send o4-1 :dissoc o4-3-1)
  (send o4-1 :dissoc o4-3-2)
  (send o4-1 :dissoc o4-3-3)
  (send o4-1 :dissoc o4-3-4)
  (send o4-1 :dissoc o4-3-5)
  (send o4-1 :dissoc o4-3-6)
  (send o4-1 :dissoc o4-3-7)
  (send o4-1 :dissoc o4-3-8)

  (send o3-1 :translate #f(10 15 0) :world) 
  (send o3-1 :rotate (deg2rad 20) :z :world) 
  (send o3-3-1 :translate #f(-20 -20 0) :world)
  (send o3-3-1 :rotate (deg2rad -10) :z :world) 
  (send o3-3-2 :translate #f(10 -15 0) :world) 
  (send o3-3-2 :rotate (deg2rad 20) :z :world)
  (send o3-3-3 :translate #f(-5 -10 0) :world)
  (send o3-3-3 :rotate (deg2rad -40) :z :world) 
  (send o3-3-4 :translate #f(20 -5 0) :world)
  (send o3-3-4 :rotate (deg2rad 50) :z :world) 
  (send o3-3-5 :translate #f(-5 0 0) :world)
  (send o3-3-5 :rotate (deg2rad 80) :z :world) 
  (send o3-3-6 :translate #f(30 5 0) :world)
  (send o3-3-6 :rotate (deg2rad -30) :z :world)
  (send o3-3-7 :rotate (deg2rad 20) :z :world) 
  (send o3-3-8 :translate #f(20 10 0) :world)
  (send o3-3-8 :rotate (deg2rad -10) :z :world)
  (send o4-1 :translate #f(20 25 0) :world)
  (send o4-1 :rotate (deg2rad -10) :z :world) 
  (send o4-3-1 :translate #f(-10 -10 0) :world)
  (send o4-3-1 :rotate (deg2rad 20) :z :world)
  (send o4-3-2 :translate #f(5 -5 0) :world)
  (send o4-3-2 :rotate (deg2rad -40) :z :world)
  (send o4-3-3 :translate #f(-25 0 0) :world)
  (send o4-3-3 :rotate (deg2rad -70) :z :world)
  (send o4-3-4 :rotate (deg2rad 80) :z :world)  
  (send o4-3-5 :translate #f(-10 5 0) :world)
  (send o4-3-5 :rotate (deg2rad -80) :z :world)
  (send o4-3-6 :translate #f(-25 15 0) :world) 
  (send o4-3-6 :rotate (deg2rad 40) :z :world) 
  (send o4-3-7 :translate #f(0 20 0) :world)
  (send o4-3-7 :rotate (deg2rad -70) :z :world)
  (send o4-3-8 :translate #f(-5 25 0) :world)
  (send o4-3-8 :rotate (deg2rad 20) :z :world) 

  (send *o* :assoc o3-1)
  (send *o* :assoc o3-3-1)
  (send *o* :assoc o3-3-2)
  (send *o* :assoc o3-3-3)
  (send *o* :assoc o3-3-4)
  (send *o* :assoc o3-3-5)
  (send *o* :assoc o3-3-6)
  (send *o* :assoc o3-3-7)
  (send *o* :assoc o3-3-8)
  (send *o* :assoc o4-1)
  (send *o* :assoc o4-3-1)
  (send *o* :assoc o4-3-2)
  (send *o* :assoc o4-3-3)
  (send *o* :assoc o4-3-4)
  (send *o* :assoc o4-3-5)
  (send *o* :assoc o4-3-6)
  (send *o* :assoc o4-3-7)
  (send *o* :assoc o4-3-8)
  (send *viewer* :draw-objects)
  (unix:usleep s-time)

  ;; stir-fry
  (send o3-1 :set-color :BurlyWood)
  (send o3-3-1 :set-color :BurlyWood)
  (send o3-3-2 :set-color :BurlyWood)
  (send o3-3-3 :set-color :BurlyWood)
  (send o3-3-4 :set-color :BurlyWood)
  (send o3-3-5 :set-color :BurlyWood)
  (send o3-3-6 :set-color :BurlyWood)
  (send o3-3-7 :set-color :BurlyWood)
  (send o3-3-8 :set-color :BurlyWood)
  (send o4-1 :set-color :BurlyWood)
  (send o4-3-1 :set-color :BurlyWood)
  (send o4-3-2 :set-color :BurlyWood)
  (send o4-3-3 :set-color :BurlyWood)
  (send o4-3-4 :set-color :BurlyWood)
  (send o4-3-5 :set-color :BurlyWood)
  (send o4-3-6 :set-color :BurlyWood)
  (send o4-3-7 :set-color :BurlyWood)
  (send o4-3-8 :set-color :BurlyWood)
  (send *viewer* :draw-objects)
  (unix:usleep s-time)

  ;; set-move
  (send *o* :move-to (send *pot* :copy-worldcoords) :world)
  (send *o* :rotate (deg2rad -90) :z :world) 
  (send *o* :translate #f(30 20 10) :world)
  (send *o* :rotate (deg2rad -90) :y :world) 
  (send *o* :copy-worldcoords)
  (send *irtviewer* :look-all
  	(geo::make-bounding-box
  	 (flatten (send-all (append *o-list* (send *pot* :bodies)) :vertices))))
  (unix:usleep s-time)
  (warn "please run (niku-stir-fry)~%")
  )

(defun niku-stir-fry ()
  ;; set
  (send nb1 :dissoc n1)
  (send nb1 :dissoc n2)
  (send nb1 :dissoc n3)
  (send nb1 :dissoc n4)
  (send nb1 :dissoc n5)
  (send nb1 :dissoc n6)
  (send nb1 :dissoc n7)
  (send nb1 :dissoc n8)
  (send n1 :assoc n2)
  (send n1 :assoc n3)
  (send n1 :assoc n4)
  (send n1 :assoc n5)
  (send n1 :assoc n6)
  (send n1 :assoc n7)
  (send n1 :assoc n8)
  (setq *n-list* (list n1 n2 n3 n4 n5 n6 n7 n8))

  (send n1 :move-to (send *pan* :copy-worldcoords) :world)
  (send n1 :translate #f(20 70 -10) :world)
  (send *irtviewer* :look-all
  	(geo::make-bounding-box
  	 (flatten (send-all (append *n-list* (send *pan* :bodies)) :vertices))))
  (send *viewer* :draw-objects)
  (unix:usleep s-time)

  ;; niku mazeru
  (setq *n* (make-cascoords))
  (send *n* :newcoords (send n1 :copy-worldcoords))
  (send n1 :dissoc n2)
  (send n1 :dissoc n3)
  (send n1 :dissoc n4)
  (send n1 :dissoc n5)
  (send n1 :dissoc n6)
  (send n1 :dissoc n7)
  (send n1 :dissoc n8)

  (send n1 :rotate (deg2rad 40) :z :world)
  (send n2 :translate #f(-10 -10 0) :world)
  (send n2 :rotate (deg2rad -30) :z :world)
  (send n3 :translate #f(45 10 0) :world)
  (send n3 :rotate (deg2rad -80) :z :world)
  (send n4 :translate #f(40 -20 0) :world) 
  (send n5 :translate #f(30 0 8) :world)
  (send n5 :rotate (deg2rad 80) :z :world)
  (send n5 :rotate (deg2rad 90) :y)
  (send n6 :translate #f(-25 25 8) :world)
  (send n6 :rotate (deg2rad 90) :y)
  (send n7 :rotate (deg2rad -80) :z :world) 
  (send n8 :translate #f(0 20 0) :world)

  (send *n* :assoc n1)
  (send *n* :assoc n2)
  (send *n* :assoc n3)
  (send *n* :assoc n4)
  (send *n* :assoc n5)
  (send *n* :assoc n6)
  (send *n* :assoc n7)
  (send *n* :assoc n8)  
  (send *irtviewer* :look-all
  	(geo::make-bounding-box
  	 (flatten (send-all (append *n-list* (send *pan* :bodies)) :vertices))))
  (send *viewer* :draw-objects)
  (unix:usleep s-time)

  ;; stir-fry
  (send n1 :set-color :RosyBrown)  
  (send n2 :set-color :RosyBrown)  
  (send n3 :set-color :RosyBrown)  
  (send n4 :set-color :RosyBrown)  
  (send n5 :set-color :RosyBrown)  
  (send n6 :set-color :RosyBrown)  
  (send n7 :set-color :RosyBrown)  
  (send n8 :set-color :RosyBrown)  
  (send *viewer* :draw-objects)
  (unix:usleep s-time)

  ;; set-move
  (send *n* :move-to (send *pot* :copy-worldcoords) :world)
  (send *n* :translate #f(20 70 20) :world)
  (send *irtviewer* :look-all
  	(geo::make-bounding-box
  	 (flatten (send-all (append *n-list* (send *pot* :bodies)) :vertices))))
  (send *viewer* :draw-objects)
  (unix:usleep s-time)
  (warn "please run (carrot-pot)~%")  
  )

(defun carrot-pot ()
  ;; move carrot
  (setq *c* (make-cascoords))
  (send *c* :newcoords (send c2-1-1 :copy-worldcoords))
  (send *c* :assoc c2-1-1)
  (send *c* :assoc c2-2-1)
  (setq *c-list* (list c2-1-1 c2-1-2 c2-1-3 c2-1-4 c2-1-5 c2-1-6 c2-1-7 c2-2-1 c2-2-2 c2-2-3 c2-2-4 c2-2-5 c2-2-6 c2-2-7))
  (send *irtviewer* :look-all
  	(geo::make-bounding-box
  	 (flatten (send-all (append *c-list* (send *pot* :bodies)) :vertices))))
  (send *viewer* :draw-objects)
  (unix:usleep s-time)


  (send *c* :move-to (send *pot* :copy-worldcoords) :world)
  (send *c* :rotate (deg2rad -90) :x)
  (send *c* :rotate (deg2rad -90) :z :world)
  (send *c* :translate #f(20 80 10) :world)

  ;; mazeru carrot
  (send *c* :dissoc c2-1-1)
  (send *c* :dissoc c2-2-1)
  (send c2-1-1 :dissoc c2-1-2)
  (send c2-1-1 :dissoc c2-1-3)
  (send c2-1-1 :dissoc c2-1-4)
  (send c2-1-1 :dissoc c2-1-5)
  (send c2-1-1 :dissoc c2-1-6)
  (send c2-1-1 :dissoc c2-1-7)
  (send c2-2-1 :dissoc c2-2-2)
  (send c2-2-1 :dissoc c2-2-3)
  (send c2-2-1 :dissoc c2-2-4)
  (send c2-2-1 :dissoc c2-2-5)
  (send c2-2-1 :dissoc c2-2-6)
  (send c2-2-1 :dissoc c2-2-7)  

  (send c2-1-1 :rotate (deg2rad 20) :z :world)
  (send c2-1-2 :rotate (deg2rad -10) :z :world) 
  (send c2-1-3 :rotate (deg2rad 70) :z :world) 
  (send c2-1-4 :rotate (deg2rad 30) :z :world)
  (send c2-1-5 :rotate (deg2rad -40) :z :world) 
  (send c2-1-6 :rotate (deg2rad -110) :z :world) 
  (send c2-1-7 :rotate (deg2rad 150) :z :world) 
  (send c2-1-1 :translate #f(5 -100 0) :world) 
  (send c2-1-2 :translate #f(-5 -70 0) :world)
  (send c2-1-3 :translate #f(5 -60 0) :world) 
  (send c2-1-4 :translate #f(-10 30 0) :world) 
  (send c2-1-5 :translate #f(50 0 0) :world) 
  (send c2-1-6 :translate #f(50 -160 0) :world)
  (send c2-1-7 :translate #f(-50 -60 0) :world)
  (send c2-2-1 :rotate (deg2rad -40) :z :world)
  (send c2-2-2 :rotate (deg2rad 60) :z :world)
  (send c2-2-3 :rotate (deg2rad -80) :z :world)
  (send c2-2-4 :rotate (deg2rad 130) :z :world) 
  (send c2-2-5 :rotate (deg2rad -110) :z :world) 
  (send c2-2-6 :rotate (deg2rad 90) :z :world)
  (send c2-2-7 :rotate (deg2rad -20) :z :world)
  (send c2-2-1 :translate #f(30 20 0) :world)
  (send c2-2-2 :translate #f(0 -20 0) :world)
  (send c2-2-3 :translate #f(70 -80 0) :world)
  (send c2-2-4 :translate #f(-90 -80 0) :world)
  (send c2-2-5 :translate #f(60 -110 0) :world)
  (send c2-2-6 :translate #f(-100 -10 0) :world)
  (send c2-2-7 :translate #f(20 -30 0) :world)

  (send *c* :assoc c2-1-1)
  (send *c* :assoc c2-1-2)
  (send *c* :assoc c2-1-3)
  (send *c* :assoc c2-1-4)
  (send *c* :assoc c2-1-5)
  (send *c* :assoc c2-1-6)
  (send *c* :assoc c2-1-7)
  (send *c* :assoc c2-2-1)
  (send *c* :assoc c2-2-2)
  (send *c* :assoc c2-2-3)
  (send *c* :assoc c2-2-4)
  (send *c* :assoc c2-2-5)
  (send *c* :assoc c2-2-6)
  (send *c* :assoc c2-2-7)

  (send *irtviewer* :look-all
  	(geo::make-bounding-box
  	 (flatten (send-all (append *c-list* (send *pot* :bodies)) :vertices))))
  (send *viewer* :draw-objects)
  (unix:usleep s-time)
  
  (warn "please run (pour-water)~%")  
  )

(defun pour-water ()
  ;; sink
  (send *mcup* :move-to (send *water-point* :copy-worldcoords) :world)
  (send *mcup* :translate #f(0 0 -70) :world)
  (send *mcup* :copy-worldcoords)
  (send *viewer* :draw-objects)
  (send *irtviewer* :look-all
	(geo::make-bounding-box
	 (flatten (send-all (send *mcup* :bodies) :vertices))))
  (unix:usleep s-time)

  ;; on water
  (setq *mcup-surface* (make-cylinder 43 10))
  (send *mcup-surface* :move-to (send (elt (send *mcup* :attention) 1) :copy-worldcoords) :world)
  (send *mcup-surface* :translate #f(0 0 -50) :world)
  (send *mcup-surface* :set-color :cyan 0.5)
  (send *mcup* :assoc *mcup-surface*)
  (objects (append obj-list (list *water* *mcup-surface*)))
  (send *irtviewer* :look-all
	(geo::make-bounding-box
	 (flatten (send-all (append (send *mcup* :bodies) (list *water*)) :vertices))))
  (unix:usleep s-time)

  ;; off water
  (objects (append obj-list (list *mcup-surface*)))
  (send *irtviewer* :look-all
  	(geo::make-bounding-box
  	 (flatten (send-all (append (send *mcup* :bodies) (list *water*)) :vertices))))
  (unix:usleep s-time)

  ;; set move
  (send *mcup* :move-to (send *pot* :copy-worldcoords) :world)
  (send *mcup* :translate #f(0 130 200) :world)
  (send *mcup* :copy-worldcoords)
  (send *irtviewer* :look-all
  	(geo::make-bounding-box
  	 (flatten (send-all (append (send *mcup* :bodies) (send *pot* :bodies)) :vertices))))
  (unix:usleep s-time)

  ;; pour water
  (send *mcup* :rotate (deg2rad 120) :x :world)
  (setq *water-current* (make-cylinder 10 120))
  (send *water-current* :set-color :cyan 0.5)
  (send *water-current* :move-to (send *pot* :copy-worldcoords) :world)
  (send *water-current* :translate #f(0 60 40) :world)
  (setq *pot-surface* (make-cylinder 100 10))
  (send *pot-surface* :move-to (send *pot* :copy-worldcoords) :world)
  (send *pot-surface* :translate #f(0 0 20) :world)
  (send *pot-surface* :set-color :cyan 0.5)
  (objects (append obj-list (list *mcup-surface* *water-current* *pot-surface*)))
  (send *irtviewer* :look-all
  	(geo::make-bounding-box
  	 (flatten (send-all (append (send *mcup* :bodies) (send *pot* :bodies)) :vertices))))
  (unix:usleep s-time)

  ;; set-move
  (if (boundp '*o*)
      (send *o* :translate #f(0 0 42) :world))
  (if (boundp '*n*)
      (send *n* :translate #f(0 0 56) :world))
  (if (boundp '*c*)
      (send *c* :translate #f(0 0 53) :world))
  (if (boundp '*p*)
      (send *p* :translate #f(0 0 42) :world))
  (setq *pot-surface* (make-cylinder 110 30))
  (send *pot-surface* :move-to (send *pot* :copy-worldcoords) :world)
  (send *pot-surface* :translate #f(0 0 52) :world)
  (send *pot-surface* :set-color :cyan 0.5)
  (send *mcup* :move-to (make-coords :pos #f(980 -330 845)) :world)
  (objects (append obj-list (list *pot-surface*)))
  (send *irtviewer* :look-all
  	(geo::make-bounding-box
  	 (flatten (send-all (send *pot* :bodies) :vertices))))
  (unix:usleep s-time)

  (warn "please run (potato-pot)~%")  
    
  )

(defun potato-pot ()
  (send p1 :assoc p2)
  (send p1 :assoc p3)
  (send p4 :assoc p5)
  (send p4 :assoc p6)
  (setq *p-list* (list p1 p2 p3 p4 p5 p6))
  (send *irtviewer* :look-all
	(geo::make-bounding-box
  	 (flatten (send-all (append *p-list* (send *pot* :bodies)) :vertices))))
  (send *viewer* :draw-objects)
  (unix:usleep s-time)


  (send p1 :move-to (send *pot* :copy-worldcoords) :world)
  (send p1 :rotate (deg2rad -90) :z :world)
  (send p1 :rotate (deg2rad -90) :x :world)
  (send p1 :translate #f(30 10 10) :world)
  (send p4 :move-to (send *pot* :copy-worldcoords) :world)
  (send p4 :rotate (deg2rad 90) :z :world)
  (send p4 :rotate (deg2rad -90) :x :world)
  (send p4 :translate #f(-30 10 10) :world)

  (send p1 :dissoc p2)
  (send p1 :dissoc p3)
  (send p4 :dissoc p5)
  (send p4 :dissoc p6)

  (setq *p* (make-cascoords))
  (send *p* :newcoords (send p1 :copy-worldcoords))

  (send p1 :rotate (deg2rad -40) :z :world)
  (send p2 :rotate (deg2rad 80) :z :world)
  (send p3 :rotate (deg2rad 20) :z :world)
  (send p4 :rotate (deg2rad 50) :z :world)
  (send p5 :rotate (deg2rad -70) :z :world)
  (send p6 :rotate (deg2rad 60) :z :world)
  (send p1 :translate #f(30 -5 0) :world)
  (send p2 :translate #f(-10 50 0) :world)
  (send p4 :translate #f(-5 40 0) :world)
  (send p5 :translate #f(-10 0 0) :world)
  (send p6 :translate #f(-15 -40 0) :world)
  
  (send *p* :assoc p1)
  (send *p* :assoc p2)
  (send *p* :assoc p3)
  (send *p* :assoc p4)
  (send *p* :assoc p5)
  (send *p* :assoc p6)

  (if (boundp '*pot-surface*)
      (send *p* :translate #f(0 0 42) :world))
 
  (send *irtviewer* :look-all
  	(geo::make-bounding-box
  	 (flatten (send-all (append *p-list* (send *pot* :bodies)) :vertices))))
  (send *viewer* :draw-objects)
  (unix:usleep s-time)

  (warn "please run (put-curry-roux)~%")  
  )

(defun put-curry-roux ()
  ;; set roux
  (send rb1 :dissoc r1)
  (send rb1 :dissoc r2)
  (send rb1 :dissoc r3)
  (send rb1 :dissoc r4)
  (send rb1 :dissoc r5)
  (send rb1 :dissoc r6)
  (send r1 :assoc r2)
  (send r1 :assoc r3)
  (send r1 :assoc r4)
  (send r1 :assoc r5)
  (send r1 :assoc r6)
  (setq *r-list* (list r1 r2 r3 r4 r5 r6))
  (send *irtviewer* :look-all
	(geo::make-bounding-box
  	 (flatten (send-all (append *r-list* (send *pot* :bodies)) :vertices))))
  (send *viewer* :draw-objects)
  (unix:usleep s-time)

  (send r1 :move-to (send *pot* :copy-worldcoords) :world)
  (send r1 :translate #f(10 40 84) :world)

  (setq *r* (make-cascoords))
  (send *r* :newcoords (send r1 :copy-worldcoords))
  (send r1 :dissoc r2)
  (send r1 :dissoc r3)
  (send r1 :dissoc r4)
  (send r1 :dissoc r5)
  (send r1 :dissoc r6)

  (send r1 :rotate (deg2rad 60) :z :world)
  (send r2 :rotate (deg2rad -20) :z :world)
  (send r3 :rotate (deg2rad -80) :z :world)
  (send r4 :rotate (deg2rad 50) :z :world)
  (send r6 :rotate (deg2rad -70) :z :world)
  (send r1 :translate #f(-40 30 0) :world)
  (send r2 :translate #f(30 0 0) :world)
  (send r3 :translate #f(45 -5 0) :world)
  (send r4 :translate #f(-25 -5 0) :world) 
  (send r6 :translate #f(-40 -20 0) :world)

  (send *r* :assoc r1)
  (send *r* :assoc r2)
  (send *r* :assoc r3)
  (send *r* :assoc r4)
  (send *r* :assoc r5)
  (send *r* :assoc r6)  

  (send *irtviewer* :look-all
  	(geo::make-bounding-box
  	 (flatten (send-all (append *r-list* (send *pot* :bodies)) :vertices))))
  (send *viewer* :draw-objects)
  (unix:usleep s-time)
  

  
  ;; change curry
  (if *pot-surface*
      (send *pot-surface* :set-color :Sienna))
  (if (boundp '*o*)
      (send *o* :translate #f(0 0 -42) :world))
  (if (boundp '*r*)
      (send *r* :translate #f(0 0 -42) :world))
  (send *irtviewer* :look-all
  	(geo::make-bounding-box
  	 (flatten (send-all (send *pot* :bodies) :vertices))))
  (send *viewer* :draw-objects)
  (unix:usleep s-time)
  
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
  (onion-stir-fry)
  (niku-stir-fry)
  (carrot-pot)
  (pour-water)
  (potato-pot)
  (put-curry-roux)
  )

(defun exec-all ()
  (onion-wash)
  (onion-peel)
  (onion-cut)
  (carrot-wash)
  (carrot-peel)
  (carrot-cut)  
  (potato-wash)
  (potato-peel)
  (potato-cut)
  (onion-stir-fry)
  (niku-stir-fry)
  (carrot-pot)
  (pour-water)
  (potato-pot)
  (put-curry-roux)
  )

(defun sitasyori ()
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

(defun kanetu ()
  (onion-stir-fry)
  (niku-stir-fry)
  (carrot-pot)
  (pour-water)
  (potato-pot)
  (put-curry-roux)
  )  


(defun onion-test ()
  (onion-wash)
  (onion-peel)
  (onion-cut)
  (onion-stir-fry)
  )

(defun carrot-test ()
  (carrot-wash)
  (carrot-peel)
  (carrot-cut)
  (carrot-pot)
  )

(defun potato-test ()
  (potato-wash)
  (potato-peel)
  (potato-cut)
  (potato-pot)
  )
