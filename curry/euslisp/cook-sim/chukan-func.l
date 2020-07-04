(defun curry-init ()

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
  (load "../model/my-pan.l")
  (setq *pan* (frying-pan))
  (send *pan* :locate #f(680 770 860))

  ;; set peeler
  (load "../model/peeler.l")
  (setq *peeler* (peeler))
  (send *peeler* :locate #f(550.0 -250.0 850.0))

  ;; set まな板
  (load "../model/cutting-board.l")
  (setq *cutting-board* (cutting-board))
  (send *cutting-board* :locate #f(650 0 825))

  ;; set 調理鍋
  (load "../model/pot-update-model.l")
  (setq *pot* (cooking-pot))
  (send *pot* :locate #f(680 500 830))

  ;; set onion
  (load "../model/onion-test-model.l")
  (setq *onion* (onion))
  (send *onion* :locate #f(860 150 845))

  ;; set carrot
  (load "../model/carrot-test-model.l")
  (setq *carrot* (carrot))
  (send *carrot* :locate #f(900 50 845))

  ;; set potato
  (load "../model/potato-test-model.l")
  (setq *potato* (potato))
  (send *potato* :locate #f(860 -50 845))

  ;; set niku
  (load "../model/niku-test.l")
  (setq *niku* (niku))
  (send *niku* :locate #f(980 -130 845))

  ;; set trash-box
  (load "../model/trash-box.l")
  (setq *trash-box* (trash-box))
  (send *trash-box* :locate #f(800 -290 830))

  ;; set mcup 
  (load "../model/mcup-update-model.l")
  (setq *mcup* (measuring-cup))
  (send *mcup* :locate #f(980 -330 845))

  ;; set roux
  (load "../model/roux-test.l")
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

  ;; def list for pot content
  (setq *pot-list* (list))
  
  ;;defin object list for visialize
  (setq obj-list (list *kitchen* *knife* *peeler* *cutting-board* *pot* *pan* *onion* *carrot* *potato* *niku* *trash-box* *mcup* *roux*))
  ;; (setq obj-list (list *kitchen* *knife* *peeler* *cutting-board* *pot* *pan* *onion* *carrot* *potato* *niku* *trash-box* *mcup* *roux* *arrow*))

  (objects obj-list)
  )

(defun stew-init ()

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
  (load "../model/my-pan.l")
  (setq *pan* (frying-pan))
  (send *pan* :locate #f(680 770 860))

  ;; set peeler
  (load "../model/peeler.l")
  (setq *peeler* (peeler))
  (send *peeler* :locate #f(550.0 -250.0 850.0))

  ;; set まな板
  (load "../model/cutting-board.l")
  (setq *cutting-board* (cutting-board))
  (send *cutting-board* :locate #f(650 0 825))

  ;; set 調理鍋
  (load "../model/pot-update-model.l")
  (setq *pot* (cooking-pot))
  (send *pot* :locate #f(680 500 830))

  ;; set onion
  (load "../model/onion-test-model.l")
  (setq *onion* (onion))
  (send *onion* :locate #f(860 150 845))

  ;; set carrot
  (load "../model/carrot-test-model.l")
  (setq *carrot* (carrot))
  (send *carrot* :locate #f(900 50 845))

  ;; set potato
  (load "../model/potato-test-model.l")
  (setq *potato* (potato))
  (send *potato* :locate #f(860 -50 845))

  ;; set niku
  (load "../model/niku-test.l")
  (setq *niku* (niku))
  (send *niku* :locate #f(980 -130 845))

  ;; set trash-box
  (load "../model/trash-box.l")
  (setq *trash-box* (trash-box))
  (send *trash-box* :locate #f(800 -290 830))

  ;; set mcup
  (load "../model/mcup-update-model.l")
  (setq *mcup* (measuring-cup))
  (send *mcup* :locate #f(980 -330 845))

  ;; set mix
  (load "../model/stew-mix.l")
  (setq *mix* (stew-mix))
  (send *mix* :locate #f(980 180 845))
  
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

  ;; def list for pot content
  (setq *pot-list* (list))
  
  ;;defin object list for visialize
  (setq obj-list (list *kitchen* *knife* *peeler* *cutting-board* *pot* *pan* *onion* *carrot* *potato* *niku* *trash-box* *mcup* *mix*))
  ;; (setq obj-list (append obj-list *arrow*))

  (objects obj-list)
  )

(defun onion-wash ()
  ;; water point
  (send *onion* :move-to (send *water-point* :copy-worldcoords) :world)
  (send *onion* :copy-worldcoords)
  (send *irtviewer* :look-all
	(geo::make-bounding-box
	 (flatten (send-all (send *onion* :bodies) :vertices))))
  (send *viewer* :draw-objects)  
  (x::window-main-one)
  (unix:usleep s-time)

  ;; on water
  (objects (append obj-list (list *water*)))
  (send *irtviewer* :look-all
	(geo::make-bounding-box
	 (flatten (send-all (append (send *onion* :bodies) (list *water*)) :vertices))))
  (send *viewer* :draw-objects)  
  (x::window-main-one)
  (unix:usleep s-time)

  ;; off water
  (objects obj-list)
  (send *irtviewer* :look-all
	(geo::make-bounding-box
	 (flatten (send-all (append (send *onion* :bodies) (list *water*)) :vertices))))
  (send *viewer* :draw-objects)  
  (x::window-main-one)
  (unix:usleep s-time)

  ;; put on cutting board
  (send *onion* :newcoords (send *cutting-board* :copy-worldcoords))
  (send *onion* :translate #f(0 0 30) :world)
  (send *onion* :copy-worldcoords)
  (send *irtviewer* :look-all
	(geo::make-bounding-box
	 (flatten (send-all (append (send *onion* :bodies) (send *cutting-board* :bodies)) :vertices))))
  (send *viewer* :draw-objects)  
  (x::window-main-one)
  (unix:usleep s-time)  
  )


(defun onion-cut-slice ()
  (if (not (boundp 'o3-3-1))
      (send *onion* :cut))
  (setq *o-list-3* (list o3-3-1 o3-3-2 o3-3-3 o3-3-4 o3-3-5 o3-3-6 o3-3-7 o3-3-8 o3-1))
  (setq *o-list-4* (list o4-3-1 o4-3-2 o4-3-3 o4-3-4 o4-3-5 o4-3-6 o4-3-7 o4-3-8 o4-1))
  (setq *o-list* (append *o-list-3* *o-list-4*))
  (send *arrow* :newcoords (send *cut-point-1* :copy-worldcoords))
  (objects obj-list)
  (send *irtviewer* :look-all
	(geo::make-bounding-box
	 (flatten (send-all (append (send *onion* :bodies) (send *cutting-board* :bodies)) :vertices))))
  (send *viewer* :draw-objects)  
  (x::window-main-one)
  (unix:usleep s-time)

  ;; f-cut-1 
  (send o3-1 :dissoc o4-1)
  (send o4-1 :translate #f(0 -40 0) :world)
  (send *irtviewer* :look-all
	(geo::make-bounding-box
	 (flatten (send-all (append (send *onion* :bodies) (send *cutting-board* :bodies)) :vertices))))
  (send *viewer* :draw-objects)  
  (x::window-main-one)
  (unix:usleep s-time)

  ;; set-move 
  (send *arrow* :newcoords (make-coords :pos #f(710 100 840) :rpy #f(1.571 0 1.571)))
  (send o3-1 :move-to (send *arrow* :copy-worldcoords) :world)
  (send *viewer* :draw-objects)
  (x::window-main-one)
  ;; (unix:usleep s-time)

  ;; set-move
  (send *arrow* :newcoords (make-coords :pos #f(650 0 840) :rpy #f(0 0 -1.571)))
  (send o4-1 :move-to (send *arrow* :copy-worldcoords) :world)
  (send *arrow* :newcoords (send *cut-point-3* :copy-worldcoords))
  (send *viewer* :draw-objects)
  (x::window-main-one)
  (unix:usleep s-time)

  ;; f-cut-2
  (send o4-1 :dissoc o6-1)
  (send o6-1 :translate #f(0 -30 0) :world)
  (send *viewer* :draw-objects)
  (x::window-main-one)
  ;; (unix:usleep s-time)

  ;; set-move
  (send o4-1 :rotate (deg2rad 180) :z :world)
  (send o4-1 :copy-worldcoords)
  (send *arrow* :newcoords (send *cut-point-2* :copy-worldcoords))
  (send *viewer* :draw-objects)
  (x::window-main-one)
  ;; (unix:usleep s-time)

  ;; f-cut-3
  (send o4-1 :dissoc o2-1)
  (send o2-1 :translate #f(0 -10 0) :world)
  (send o2-1 :copy-worldcoords)
  (send *viewer* :draw-objects)
  (x::window-main-one)
  (unix:usleep s-time)
  
  ;; set-move
  (send o6-1 :move-to (send *trash-point* :copy-worldcoords) :world)
  (send o2-1 :move-to (send *trash-point* :copy-worldcoords) :world)
  (send o2-1 :copy-worldcoords)
  (send o6-1 :copy-worldcoords)
  (send *irtviewer* :look-all
	(geo::make-bounding-box
	 (flatten (send-all (append (send *onion* :bodies) (send *cutting-board* :bodies)) :vertices))))
  (send *viewer* :draw-objects)
  (x::window-main-one)
  ;; (unix:usleep s-time)

  ;; peel
  (send o4-1 :dissoc o4-2)
  (send o4-2 :move-to (send *trash-point* :copy-worldcoords) :world)
  (send o4-2 :copy-worldcoords)
  (send *irtviewer* :look-all
	(geo::make-bounding-box
	 (flatten (send-all (append (send *onion* :bodies) (send *cutting-board* :bodies)) :vertices))))
  (send *viewer* :draw-objects)
  (x::window-main-one)
  (unix:usleep s-time)

  ;; set-move
  (send *arrow* :newcoords (make-coords :pos #f(710 -100 840) :rpy #f(-1.571 0 -1.571)))
  (send o4-1 :move-to (send *arrow* :copy-worldcoords) :world)
  (send *irtviewer* :look-all
	(geo::make-bounding-box
	 (flatten (send-all (append (send *onion* :bodies) (send *cutting-board* :bodies)) :vertices))))
  (send *viewer* :draw-objects)
  (x::window-main-one)
  ;; (unix:usleep s-time)

  ;; set-move
  (send *arrow* :newcoords (make-coords :pos #f(650 0 840) :rpy #f(0 0 1.571)))
  (send o3-1 :move-to (send *arrow* :copy-worldcoords) :world)
  (send *arrow* :newcoords (send *cut-point-4* :copy-worldcoords))
  (send *viewer* :draw-objects)
  (x::window-main-one)
  (unix:usleep s-time)

  ;; f-cut-4
  (send o3-1 :dissoc o1-1)
  (send o1-1 :translate #f(0 -30 0) :world)
  (send o1-1 :copy-worldcoords)
  (send *viewer* :draw-objects)
  ;; (unix:usleep s-time)

  ;; set-move
  (send o3-1 :rotate (deg2rad 180) :z :world)
  (send o3-1 :copy-worldcoords)
  (send *arrow* :newcoords (send *cut-point-5* :copy-worldcoords))
  (send *viewer* :draw-objects)
  (x::window-main-one)
  ;; (unix:usleep s-time)

  ;; f-cut-5
  (send o3-1 :dissoc o5-1)
  (send o5-1 :translate #f(0 -10 0) :world)
  (send o5-1 :copy-worldcoords)
  (send *viewer* :draw-objects)
  (x::window-main-one)
  (unix:usleep s-time)

  ;; set-move
  (send o5-1 :move-to (send *trash-point* :copy-worldcoords) :world)
  (send o1-1 :move-to (send *trash-point* :copy-worldcoords) :world)
  (send o5-1 :copy-worldcoords)
  (send o1-1 :copy-worldcoords)
  (send *irtviewer* :look-all
	(geo::make-bounding-box
	 (flatten (send-all (append (send *onion* :bodies) (send *cutting-board* :bodies)) :vertices))))
  (send *viewer* :draw-objects)
  (x::window-main-one)
  ;; (unix:usleep s-time)

  ;; peel
  (send o3-1 :dissoc o3-2)
  (send o3-2 :move-to (send *trash-point* :copy-worldcoords) :world)
  (send o3-2 :copy-worldcoords)
  (send *irtviewer* :look-all
	(geo::make-bounding-box
	 (flatten (send-all (append (send *onion* :bodies) (send *cutting-board* :bodies)) :vertices))))
  (send *viewer* :draw-objects)
  (x::window-main-one)
  (unix:usleep s-time)

  ;; (defun onion-cut ()
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
  (send *viewer* :draw-objects)
  (x::window-main-one)
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
  (x::window-main-one)
  ;; (unix:usleep s-time)

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
  (x::window-main-one)
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

  (send o3-1 :move-to (make-coords :pos #f(870 200 835)) :world)
  (send o3-1 :rotate (deg2rad -90) :z :world) 
  (send o3-1 :translate #f(30 20 0) :world)
  (send o3-1 :rotate (deg2rad -90) :y :world) 
  (send o3-1 :copy-worldcoords)
  (send o4-1 :move-to (make-coords :pos #f(870 200 835)) :world)
  (send o4-1 :rotate (deg2rad -90) :z :world) 
  (send o4-1 :translate #f(-30 20 0) :world)
  (send o4-1 :rotate (deg2rad 90) :y :world) 
  (send o4-1 :copy-worldcoords)

  (send *irtviewer* :look-all
	(geo::make-bounding-box
	 (flatten (send-all (append (send *onion* :bodies) (send *cutting-board* :bodies)) :vertices))))
  (send *viewer* :draw-objects)
  (x::window-main-one)
  (unix:usleep s-time)
  )

(defun onion-cut-wedges ()
  (if (not (boundp 'o3-3-1))
      (send *onion* :wedges))
  (setq *o-list-3* (list o3-3-1 o3-3-2 o3-3-3 o3-1))
  (setq *o-list-4* (list o4-3-1 o4-3-2 o4-3-3 o4-1))
  (setq *o-list* (append *o-list-3* *o-list-4*))
  (send *arrow* :newcoords (send *cut-point-1* :copy-worldcoords))
  (objects obj-list)
  (send *irtviewer* :look-all
	(geo::make-bounding-box
	 (flatten (send-all (append (send *onion* :bodies) (send *cutting-board* :bodies)) :vertices))))
  (send *viewer* :draw-objects)  
  (x::window-main-one)
  (unix:usleep s-time)

  ;; f-cut-1 
  (send o3-1 :dissoc o4-1)
  (send o4-1 :translate #f(0 -40 0) :world)
  (send *irtviewer* :look-all
	(geo::make-bounding-box
	 (flatten (send-all (append (send *onion* :bodies) (send *cutting-board* :bodies)) :vertices))))
  (send *viewer* :draw-objects)  
  (x::window-main-one)
  (unix:usleep s-time)

  ;; set-move 
  (send *arrow* :newcoords (make-coords :pos #f(710 100 840) :rpy #f(1.571 0 1.571)))
  (send o3-1 :move-to (send *arrow* :copy-worldcoords) :world)
  (send *viewer* :draw-objects)
  (x::window-main-one)
  ;; (unix:usleep s-time)

  ;; set-move
  (send *arrow* :newcoords (make-coords :pos #f(650 0 840) :rpy #f(0 0 -1.571)))
  (send o4-1 :move-to (send *arrow* :copy-worldcoords) :world)
  (send *arrow* :newcoords (send *cut-point-3* :copy-worldcoords))
  (send *viewer* :draw-objects)
  (x::window-main-one)
  (unix:usleep s-time)

  ;; f-cut-2
  (send o4-1 :dissoc o6-1)
  (send o6-1 :translate #f(0 -30 0) :world)
  (send *viewer* :draw-objects)
  (x::window-main-one)
  ;; (unix:usleep s-time)

  ;; set-move
  (send o4-1 :rotate (deg2rad 180) :z :world)
  (send o4-1 :copy-worldcoords)
  (send *arrow* :newcoords (send *cut-point-2* :copy-worldcoords))
  (send *viewer* :draw-objects)
  (x::window-main-one)
  ;; (unix:usleep s-time)

  ;; f-cut-3
  (send o4-1 :dissoc o2-1)
  (send o2-1 :translate #f(0 -10 0) :world)
  (send o2-1 :copy-worldcoords)
  (send *viewer* :draw-objects)
  (x::window-main-one)
  (unix:usleep s-time)
  
  ;; set-move
  (send o6-1 :move-to (send *trash-point* :copy-worldcoords) :world)
  (send o2-1 :move-to (send *trash-point* :copy-worldcoords) :world)
  (send o2-1 :copy-worldcoords)
  (send o6-1 :copy-worldcoords)
  (send *irtviewer* :look-all
	(geo::make-bounding-box
	 (flatten (send-all (append (send *onion* :bodies) (send *cutting-board* :bodies)) :vertices))))
  (send *viewer* :draw-objects)
  (x::window-main-one)
  ;; (unix:usleep s-time)

  ;; peel
  (send o4-1 :dissoc o4-2)
  (send o4-2 :move-to (send *trash-point* :copy-worldcoords) :world)
  (send o4-2 :copy-worldcoords)
  (send *irtviewer* :look-all
	(geo::make-bounding-box
	 (flatten (send-all (append (send *onion* :bodies) (send *cutting-board* :bodies)) :vertices))))
  (send *viewer* :draw-objects)
  (x::window-main-one)
  (unix:usleep s-time)

  ;; set-move
  (send *arrow* :newcoords (make-coords :pos #f(710 -100 840) :rpy #f(-1.571 0 -1.571)))
  (send o4-1 :move-to (send *arrow* :copy-worldcoords) :world)
  (send *irtviewer* :look-all
	(geo::make-bounding-box
	 (flatten (send-all (append (send *onion* :bodies) (send *cutting-board* :bodies)) :vertices))))
  (send *viewer* :draw-objects)
  (x::window-main-one)
  ;; (unix:usleep s-time)

  ;; set-move
  (send *arrow* :newcoords (make-coords :pos #f(650 0 840) :rpy #f(0 0 1.571)))
  (send o3-1 :move-to (send *arrow* :copy-worldcoords) :world)
  (send *arrow* :newcoords (send *cut-point-4* :copy-worldcoords))
  (send *viewer* :draw-objects)
  (x::window-main-one)
  (unix:usleep s-time)

  ;; f-cut-4
  (send o3-1 :dissoc o1-1)
  (send o1-1 :translate #f(0 -30 0) :world)
  (send o1-1 :copy-worldcoords)
  (send *viewer* :draw-objects)
  ;; (unix:usleep s-time)

  ;; set-move
  (send o3-1 :rotate (deg2rad 180) :z :world)
  (send o3-1 :copy-worldcoords)
  (send *arrow* :newcoords (send *cut-point-5* :copy-worldcoords))
  (send *viewer* :draw-objects)
  (x::window-main-one)
  ;; (unix:usleep s-time)

  ;; f-cut-5
  (send o3-1 :dissoc o5-1)
  (send o5-1 :translate #f(0 -10 0) :world)
  (send o5-1 :copy-worldcoords)
  (send *viewer* :draw-objects)
  (x::window-main-one)
  (unix:usleep s-time)

  ;; set-move
  (send o5-1 :move-to (send *trash-point* :copy-worldcoords) :world)
  (send o1-1 :move-to (send *trash-point* :copy-worldcoords) :world)
  (send o5-1 :copy-worldcoords)
  (send o1-1 :copy-worldcoords)
  (send *irtviewer* :look-all
	(geo::make-bounding-box
	 (flatten (send-all (append (send *onion* :bodies) (send *cutting-board* :bodies)) :vertices))))
  (send *viewer* :draw-objects)
  (x::window-main-one)
  ;; (unix:usleep s-time)

  ;; peel
  (send o3-1 :dissoc o3-2)
  (send o3-2 :move-to (send *trash-point* :copy-worldcoords) :world)
  (send o3-2 :copy-worldcoords)
  (send *irtviewer* :look-all
	(geo::make-bounding-box
	 (flatten (send-all (append (send *onion* :bodies) (send *cutting-board* :bodies)) :vertices))))
  (send *viewer* :draw-objects)
  (x::window-main-one)
  (unix:usleep s-time)

  ;; cut-part
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
  (send *viewer* :draw-objects)
  (x::window-main-one)
  (unix:usleep s-time)

  ;; cut-1
  (send o3-1 :dissoc o3-3-1)
  (send o3-1 :dissoc o3-3-2)
  (send o3-1 :dissoc o3-3-3)
  (send o3-1 :locate #f(-15 0 0))
  (send o3-3-3 :locate #f(-5 0 0))
  (send o3-3-2 :locate #f(5 0 0))
  (send o3-3-1 :locate #f(15 0 0))  
  (send *viewer* :draw-objects)
  (x::window-main-one)
  ;; (unix:usleep s-time)

  (send o4-1 :dissoc o4-3-1)
  (send o4-1 :dissoc o4-3-2)
  (send o4-1 :dissoc o4-3-3)
  (send o4-1 :locate #f(-15 0 0))
  (send o4-3-3 :locate #f(-5 0 0))
  (send o4-3-2 :locate #f(5 0 0))
  (send o4-3-1 :locate #f(15 0 0))
  (send *viewer* :draw-objects)
  (x::window-main-one)
  (unix:usleep s-time)

  ;; set-move
  (send o3-1 :assoc o3-3-1)
  (send o3-1 :assoc o3-3-2)
  (send o3-1 :assoc o3-3-3)
  (send o4-1 :assoc o4-3-1)
  (send o4-1 :assoc o4-3-2)
  (send o4-1 :assoc o4-3-3)

  (send o3-1 :move-to (make-coords :pos #f(870 200 835)) :world)
  (send o3-1 :rotate (deg2rad -90) :z :world) 
  (send o3-1 :translate #f(30 20 0) :world)
  (send o3-1 :rotate (deg2rad -90) :y :world) 
  (send o3-1 :copy-worldcoords)
  (send o4-1 :move-to (make-coords :pos #f(870 200 835)) :world)
  (send o4-1 :rotate (deg2rad -90) :z :world) 
  (send o4-1 :translate #f(-30 20 0) :world)
  (send o4-1 :rotate (deg2rad 90) :y :world) 
  (send o4-1 :copy-worldcoords)

  (send *irtviewer* :look-all
	(geo::make-bounding-box
	 (flatten (send-all (append (send *onion* :bodies) (send *cutting-board* :bodies)) :vertices))))
  (send *viewer* :draw-objects)
  (x::window-main-one)
  (unix:usleep s-time)
  )


(defun onion-slice ()
  (onion-wash)
  (onion-cut-slice)
  )

(defun onion-wedges ()
  (onion-wash)
  (onion-cut-wedges)
  )

(defun carrot-wash ()
  ;; water point
  (send *carrot* :move-to (send *water-point* :copy-worldcoords) :world)
  (send *carrot* :rotate (deg2rad -90) :z :world)
  (send *carrot* :copy-worldcoords)
  (send *irtviewer* :look-all
	(geo::make-bounding-box
	 (flatten (send-all (send *carrot* :bodies) :vertices))))
  (send *viewer* :draw-objects)
  (x::window-main-one)
  (unix:usleep s-time)

  ;; on water
  (objects (append obj-list (list *water*)))
  (send *irtviewer* :look-all
	(geo::make-bounding-box
	 (flatten (send-all (append (send *carrot* :bodies) (list *water*)) :vertices))))
  (send *viewer* :draw-objects)
  (x::window-main-one)
  (unix:usleep s-time)

  ;; off water
  (objects obj-list)
  (send *irtviewer* :look-all
	(geo::make-bounding-box
	 (flatten (send-all (append (send *carrot* :bodies) (list *water*)) :vertices))))
  (send *viewer* :draw-objects)
  (x::window-main-one)
  (unix:usleep s-time)

  ;; put on cutting board
  (send *carrot* :newcoords (send *cutting-board* :copy-worldcoords))
  (send *carrot* :translate #f(0 0 30) :world)
  (send *carrot* :rotate (deg2rad -90) :z :world)
  (send *carrot* :copy-worldcoords)
  (send *irtviewer* :look-all
	(geo::make-bounding-box
	 (flatten (send-all (append (send *carrot* :bodies) (send *cutting-board* :bodies)) :vertices))))
  (send *viewer* :draw-objects)
  (x::window-main-one)
  (unix:usleep s-time)
  )
  
;; (defun carrot-peel ()
(defun  carrot-cut-half-moon ()
  (if (not (boundp 'c2-1-1))
      (send *carrot* :cut))  
  (setq *c-list-1* (list c2-1-1 c2-1-2 c2-1-3 c2-1-4 c2-1-5 c2-1-6 c2-1-7))
  (setq *c-list-2* (list c2-2-1 c2-2-2 c2-2-3 c2-2-4 c2-2-5 c2-2-6 c2-2-7))
  (setq *c-list* (append *c-list-1* *c-list-2*))
  (send *arrow* :newcoords (send *cut-point-1* :copy-worldcoords))
  (objects obj-list)
  (send *irtviewer* :look-all
	(geo::make-bounding-box
	 (flatten (send-all (append (send *carrot* :bodies) (send *cutting-board* :bodies)) :vertices))))
  (send *viewer* :draw-objects)
  (x::window-main-one)
  (unix:usleep s-time)

  ;; f-cut-1 
  (send c2-1-1 :dissoc c1)
  (send c1 :translate #f(0 -30 0) :world)
  (send c1 :copy-worldcoords)
  (send *viewer* :draw-objects)
  (x::window-main-one)
  ;; (unix:usleep s-time)

  ;; set-move
  (send *arrow* :newcoords (send *cut-point-2* :copy-worldcoords))
  (send *viewer* :draw-objects)
  (x::window-main-one)
  
  ;; f-cut-2
  (send c2-1-1 :dissoc c3-1-1)
  (send c2-1-1 :translate #f(0 -20 0) :world)
  (send c2-1-1 :copy-worldcoords)
  (send *irtviewer* :look-all
	(geo::make-bounding-box
	 (flatten (send-all (append (send *carrot* :bodies) (send *cutting-board* :bodies)) :vertices))))
  (send *viewer* :draw-objects)
  (x::window-main-one)
  (unix:usleep s-time)

  ;; set-move
  (send c1 :move-to (send *trash-point* :copy-worldcoords) :world)
  (send c1 :translate #f(-80 0 0) :world)
  (send c1 :copy-worldcoords)
  (send *irtviewer* :look-all
	(geo::make-bounding-box
	 (flatten (send-all (append (send *carrot* :bodies) (send *cutting-board* :bodies)) :vertices))))
  (send *viewer* :draw-objects)
  (x::window-main-one)
  ;; (unix:usleep s-time)

  (send c3-1-1 :move-to (make-coords :pos #f(900 0 845)) :world)
  (send c3-1-1 :copy-worldcoords)
  (send *arrow* :newcoords (send *cut-point-4* :copy-worldcoords))
  (send *irtviewer* :look-all
	(geo::make-bounding-box
	 (flatten (send-all (append (send *carrot* :bodies) (send *cutting-board* :bodies)) :vertices))))
  (send *viewer* :draw-objects)
  (x::window-main-one)
  (unix:usleep s-time)

  ;; (defun carrot-cut ()
  ;; cut-1
  (send c2-1-1 :dissoc c2-2-1)
  (send c2-1-1 :translate #f(0 -20 0))
  (send *viewer* :draw-objects)
  (x::window-main-one)
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
  (send *viewer* :draw-objects)
  (x::window-main-one)
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
  (x::window-main-one)
  ;; (unix:usleep s-time)

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
  (x::window-main-one)
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
  (x::window-main-one)
  (unix:usleep s-time)
)

(defun  carrot-cut-random ()
  (if (not (boundp 'c2-1-1))
      (send *carrot* :random))  
  (setq *c-list-1* (list c2-1-1 c2-1-2 c2-1-3 c2-1-4))
  (setq *c-list-2* (list c2-1-5 c2-1-6 c2-1-7 c2-1-8))
  (setq *c-list* (append *c-list-1* *c-list-2*))
  (send *arrow* :newcoords (send *cut-point-1* :copy-worldcoords))
  (objects obj-list)
  (send *irtviewer* :look-all
	(geo::make-bounding-box
	 (flatten (send-all (append (send *carrot* :bodies) (send *cutting-board* :bodies)) :vertices))))
  (send *viewer* :draw-objects)
  (x::window-main-one)
  (unix:usleep s-time)

  ;; f-cut-1 
  (send c2-1-1 :dissoc c1)
  (send c1 :translate #f(0 -30 0) :world)
  (send c1 :copy-worldcoords)
  (send *viewer* :draw-objects)
  (x::window-main-one)
  ;; (unix:usleep s-time)

  ;; set-move
  (send *arrow* :newcoords (send *cut-point-2* :copy-worldcoords))
  (send *viewer* :draw-objects)
  (x::window-main-one)
  
  ;; f-cut-2
  (send c2-1-1 :dissoc c3-1-1)
  (send c2-1-1 :translate #f(0 -20 0) :world)
  (send c2-1-1 :copy-worldcoords)
  (send *irtviewer* :look-all
	(geo::make-bounding-box
	 (flatten (send-all (append (send *carrot* :bodies) (send *cutting-board* :bodies)) :vertices))))
  (send *viewer* :draw-objects)
  (x::window-main-one)
  (unix:usleep s-time)

  ;; set-move
  (send c1 :move-to (send *trash-point* :copy-worldcoords) :world)
  (send c1 :translate #f(-80 0 0) :world)
  (send c1 :copy-worldcoords)
  (send *irtviewer* :look-all
	(geo::make-bounding-box
	 (flatten (send-all (append (send *carrot* :bodies) (send *cutting-board* :bodies)) :vertices))))
  (send *viewer* :draw-objects)
  (x::window-main-one)
  ;; (unix:usleep s-time)

  (send c3-1-1 :move-to (make-coords :pos #f(900 0 845)) :world)
  (send c3-1-1 :copy-worldcoords)
  (send *arrow* :newcoords (send *cut-point-4* :copy-worldcoords))
  (send *irtviewer* :look-all
	(geo::make-bounding-box
	 (flatten (send-all (append (send *carrot* :bodies) (send *cutting-board* :bodies)) :vertices))))
  (send *viewer* :draw-objects)
  (x::window-main-one)
  (unix:usleep s-time)

  ;; (defun carrot-cut ()

  ;; cut
  (send c2-1-1 :translate #f(0 60 0) :world)
  
  (send c2-1-1 :dissoc c2-1-2)
  (send c2-1-1 :dissoc c2-1-3)
  (send c2-1-1 :dissoc c2-1-4)
  (send c2-1-1 :dissoc c2-1-5)
  (send c2-1-1 :dissoc c2-1-6)
  (send c2-1-1 :dissoc c2-1-7)
  (send c2-1-1 :dissoc c2-1-8)
  (send c2-1-1 :locate #f(48 0 0))
  (send c2-1-2 :locate #f(36 0 0))
  (send c2-1-3 :locate #f(24 0 0))
  (send c2-1-4 :locate #f(12 0 0))
  (send c2-1-5 :locate #f(0 0 0))
  (send c2-1-6 :locate #f(-12 0 0))
  (send c2-1-7 :locate #f(-24 0 0))
  (send c2-1-8 :locate #f(-36 0 0))
  (send *viewer* :draw-objects)
  (x::window-main-one)
  (unix:usleep s-time)

  ;; set-move
  (send c2-1-1 :assoc c2-1-2)
  (send c2-1-1 :assoc c2-1-3)
  (send c2-1-1 :assoc c2-1-4)
  (send c2-1-1 :assoc c2-1-5)
  (send c2-1-1 :assoc c2-1-6)
  (send c2-1-1 :assoc c2-1-7)
  (send c2-1-1 :assoc c2-1-8)
  (send c2-1-1 :move-to (make-coords :pos #f(760 280 835) :rpy #f(-1.571 0 -1.571)) :world)
  (send *irtviewer* :look-all
	(geo::make-bounding-box
	 (flatten (send-all (append (send *carrot* :bodies) (send *cutting-board* :bodies)) :vertices))))
  (send *viewer* :draw-objects)
  (x::window-main-one)
  (unix:usleep s-time)
  )


(defun carrot-half-moon () ;;人参を半月切り
  (carrot-wash)
  (carrot-cut-half-moon)
  )

(defun carrot-random () ;;人参を半月切り
  (carrot-wash)
  (carrot-cut-random)
  )

(defun potato-wash ()
  ;; water point
  (send *potato* :move-to (send *water-point* :copy-worldcoords) :world)
  (send *potato* :rotate (deg2rad -90) :z :world)
  (send *potato* :copy-worldcoords)
  (send *irtviewer* :look-all
	(geo::make-bounding-box
	 (flatten (send-all (send *potato* :bodies) :vertices))))
  (send *viewer* :draw-objects)
  (x::window-main-one)
  (unix:usleep s-time)

  ;; on water
  (objects (append obj-list (list *water*)))
  (send *irtviewer* :look-all
	(geo::make-bounding-box
	 (flatten (send-all (append (send *potato* :bodies) (list *water*)) :vertices))))
  (send *viewer* :draw-objects)
  (x::window-main-one)
  (unix:usleep s-time)

  ;; off water
  (objects obj-list)
  (send *irtviewer* :look-all
	(geo::make-bounding-box
	 (flatten (send-all (append (send *potato* :bodies) (list *water*)) :vertices))))
  (send *viewer* :draw-objects)
  (x::window-main-one)
  (unix:usleep s-time)

  ;; put on cutting board
  (send *potato* :newcoords (send *cutting-board* :copy-worldcoords))
  (send *potato* :translate #f(0 0 30) :world)
  (send *potato* :rotate (deg2rad -90) :z :world)
  (send *potato* :copy-worldcoords)
  (send *irtviewer* :look-all
	(geo::make-bounding-box
	 (flatten (send-all (append (send *potato* :bodies) (send *cutting-board* :bodies)) :vertices))))
  (send *viewer* :draw-objects)
  (x::window-main-one)
  (unix:usleep s-time)
  )


(defun potato-peel ()
  (send *potato* :peel)
  (objects obj-list)
  (send *irtviewer* :look-all
	(geo::make-bounding-box
	 (flatten (send-all (append (send *potato* :bodies) (send *cutting-board* :bodies)) :vertices))))
  (send *viewer* :draw-objects)
  (x::window-main-one)
  (unix:usleep s-time)

  ;; peel-1
  (send p1 :set-color :moccasin)
  (send *viewer* :draw-objects)
  (x::window-main-one)
  ;; (unix:usleep s-time)

  ;; set-move
  (send *potato* :rotate (deg2rad 90) :x)
  (send *viewer* :draw-objects)
  (x::window-main-one)
  ;; (unix:usleep s-time)

  ;; peel-2
  (send p2 :set-color :moccasin)
  (send *viewer* :draw-objects)
  (x::window-main-one)
  ;; (unix:usleep s-time)
  
  ;; set-move
  (send *potato* :rotate (deg2rad 90) :x)
  (send *viewer* :draw-objects)
  (x::window-main-one)
  ;; (unix:usleep s-time)

  ;; peel-3
  (send p3 :set-color :moccasin)
  (send *viewer* :draw-objects)
  (x::window-main-one)
  ;; (unix:usleep s-time)

    ;; set-move
  (send *potato* :rotate (deg2rad 90) :x)
  (send *viewer* :draw-objects)
  (x::window-main-one)
  ;; (unix:usleep s-time)

  ;; peel-4
  (send p4 :set-color :moccasin)
  (send *viewer* :draw-objects)
  (x::window-main-one)
  ;; (unix:usleep s-time)

  ;; set-move
  (send *potato* :rotate (deg2rad 90) :x)
  (send *viewer* :draw-objects)
  (x::window-main-one)
  (unix:usleep s-time)
  )

(defun potato-cut ()
  (send *potato* :cut)
  (setq *p-list-1* (list p1 p2 p3))
  (setq *p-list-2* (list p4 p5 p6))
  (setq *p-list* (append *p-list-1* *p-list-2*))
  (send *arrow* :newcoords (send *cut-point-1* :copy-worldcoords))
  (objects obj-list)
  (send *irtviewer* :look-all
	(geo::make-bounding-box
	 (flatten (send-all (append (send *potato* :bodies) (send *cutting-board* :bodies)) :vertices))))
  (send *viewer* :draw-objects)
  (x::window-main-one)
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
  (x::window-main-one)
  (unix:usleep s-time)

  ;; set-move
  (send *arrow* :newcoords (make-coords :pos #f(710 100 840) :rpy #f(0.785 1.571 -0.785)))
  (send *potato* :move-to (send *arrow* :copy-worldcoords) :world)
  (send *viewer* :draw-objects)
  (x::window-main-one)
  ;; (unix:usleep s-time)

  (send *arrow* :newcoords (make-coords :pos #f(650 -60 840) :rpy #f(0.785 -1.571 -2.357)))
  (send *potato2* :move-to (send *arrow* :copy-worldcoords) :world)
  (send *arrow* :newcoords (send *cut-point-2* :copy-worldcoords))
  (send *viewer* :draw-objects)
  (x::window-main-one)
  (unix:usleep s-time)

  ;; cut-2
  (send *potato2* :dissoc p3)
  (send p3 :translate #f(0 -20 0) :world)
  (send *viewer* :draw-objects)
  (x::window-main-one)
  ;; (unix:usleep s-time)

  ;; set-move
  (send *arrow* :newcoords (send *cut-point-3* :copy-worldcoords))
  (send *viewer* :draw-objects)
  (x::window-main-one)

  ;; cut-3
  (send *potato2* :dissoc p2)
  (send p2 :translate #f(0 -10 0) :world)
  (send *viewer* :draw-objects)
  (x::window-main-one)
  (unix:usleep s-time)

  ;; set-move
  (send *arrow* :newcoords (make-coords :pos #f(650 60 840) :rpy #f(0.785 1.571 -0.785)))
  (send *potato* :move-to (send *arrow* :copy-worldcoords) :world)
  (send *arrow* :newcoords (send *cut-point-4* :copy-worldcoords))
  (send *viewer* :draw-objects)
  (x::window-main-one)
  (unix:usleep s-time)

  ;; cut-4
  (send *potato* :dissoc p6)
  (send p6 :translate #f(0 -20 0) :world)
  (send *viewer* :draw-objects)
  (x::window-main-one)
  ;; (unix:usleep s-time)

  ;; set-move
  (send *arrow* :newcoords (send *cut-point-5* :copy-worldcoords))
  (send *viewer* :draw-objects)
  (x::window-main-one)

  ;; cut-5
  (send *potato* :dissoc p5)
  (send p5 :translate #f(0 -10 0) :world)
  (send *viewer* :draw-objects)
  (x::window-main-one)
  (unix:usleep s-time)

  (send p1 :assoc p2)
  (send p1 :assoc p3)
  (send p4 :assoc p5)
  (send p4 :assoc p6)
  
  )

(defun potato-bite-size () ;;じゃがいもを一口大にする
  (potato-wash)
  (potato-peel)
  (potato-cut)
  )

;; add fot mix code
(defun content-mix-move (abody1 abody2)
  (let (box1 box2 bc m1 m2 mn target)
    (send abody1 :move-to (make-coords :pos (send abody1 :worldpos) :rpy (float-vector (random 6.28) (random 6.28) (random 6.28)) ) :world)
    (send abody1 :copy-worldcoords)
    (setq box1 (make-bounding-box (send abody1 :vertices)))
    (setq bc (make-cascoords :pos (send box1 :center)))
    (setq m1 (v- (send box1 :maxpoint) (send box1 :minpoint)))
  
    (send abody2 :copy-worldcoords)
    (setq box2 (make-bounding-box (send abody2 :vertices)))
    (setq m2 (v- (send box2 :maxpoint) (send box2 :minpoint)))
    (setq mn (v- m2 (float-vector (* (elt m1 0) 1.5) (* (elt m1 1) 1.5) (* (elt m1 2) 0.5)) ));;上に少し余裕を
    
    (if (send abody1 :parent) (send (send abody1 :parent) :dissoc abody1))
    (send bc :assoc abody1)
  
    (setq target (make-coords :pos (v+ (float-vector (random (elt mn 0)) (random (elt mn 1))  (random (elt mn 2)))  (v+ (send box2 :minpoint)  (float-vector (* (elt m1 0) 0.75) (* (elt m1 1) 0.75) (* (elt m1 2) 0.5))))))
    
    (send bc :move-to target :world))
  )

(defun bottom-mix-move (abody1 abody2)
  (let (box1 box2 bc m1 m2 mn target)
    (send abody1 :rotate (deg2rad (random 360)) :z :world)
    (send abody1 :copy-worldcoords)
    (setq box1 (make-bounding-box (send abody1 :vertices)))
    (setq bc (make-cascoords :pos (send box1 :center)))
    (setq m1 (v- (send box1 :maxpoint) (send box1 :minpoint)))
    (send bc :translate (float-vector 0 0 (/ (elt m1 2) -2.0)) :world)
    
    (send abody2 :copy-worldcoords)
    (setq box2 (make-bounding-box (send abody2 :vertices)))
    (setq m2 (v- (send box2 :maxpoint) (send box2 :minpoint)))
    (setq mn (v- m2 (float-vector (* (elt m1 0) 1.5) (* (elt m1 1) 1.5) 0))) ;; 余分に入れている。
    
    (if (send abody1 :parent) (send (send abody1 :parent) :dissoc abody1))
    (send bc :assoc abody1)
    
    (setq target (make-coords :pos (v+ (float-vector (random (elt mn 0)) (random (elt mn 1))  (random (elt mn 2)))  (v+ (send box2 :minpoint)  (float-vector (* (elt m1 0) 0.75) (* (elt m1 1) 0.75) 0)))))

    (send bc :move-to target :world))
    )

(defun list-pqp-check (abody o-list)
  (let (t-flag)
    (setq t-flag t)
    (dolist (x o-list)
      (if (= (pqp-collision-check abody x) 1)
	  (setq t-flag nil))) 
    t-flag))

(defun bottom-mix (container bottom bodies)
  (let (c-flag pqp-list)
    (setq pqp-list (list container))
    (dolist (x bodies)
      (setq c-flag nil)
      (until c-flag
	     (bottom-mix-move x bottom)
	     (if (list-pqp-check x pqp-list)
		 (setq c-flag t)))
      (push x pqp-list)
      )))

(defun water-mix (container nakami bodies)
  (let (c-flag pqp-list)
    (setq pqp-list (list container))
    (dolist (x bodies)
      (setq c-flag nil)
      (until c-flag
	     (content-mix-move x nakami)
	     (if (list-pqp-check x pqp-list)
		 (setq c-flag t)))
      (push x pqp-list)
      )))



(defun niku-pan ()
  (setq *n-list* (list n1 n2 n3 n4 n5 n6 n7 n8))
  (send *irtviewer* :look-all
	(geo::make-bounding-box
	 (flatten (send-all (append *n-list* (send *pan* :bodies)) :vertices))))
  (send *viewer* :draw-objects)
  (x::window-main-one)
  (unix:usleep s-time)

  (dolist (x *n-list*)
    (if (send x :parent) (send (send x :parent) :dissoc x))
    (send x :move-to (send *pan* :copy-worldcoords) :world)
    )
  (setq *pan-bottom* (send *pan* :bottom))
  
  (bottom-mix *pan* *pan-bottom* *n-list*)
  (send *irtviewer* :look-all
	(geo::make-bounding-box
	 (flatten (send-all (append *n-list* (send *pan* :bodies)) :vertices))))
  (send *viewer* :draw-objects)
  (x::window-main-one)
  (unix:usleep s-time)
  
  ;; stir-fry
  (dolist (x *n-list*)
    (send x :set-color :RosyBrown)
    )
  (send *viewer* :draw-objects)
  (x::window-main-one)
  (unix:usleep s-time)  
  )

(defun niku-pot ()
  (send *irtviewer* :look-all
	(geo::make-bounding-box
	 (flatten (send-all (append *n-list* (send *pot* :bodies)) :vertices))))
  (send *viewer* :draw-objects)
  (x::window-main-one)
  (unix:usleep s-time)
  
  (dolist (x *n-list*)
    (if (send x :parent) (send (send x :parent) :dissoc x))
    (send x :move-to (send *pot* :copy-worldcoords) :world)
    )

  (setq *pot-bottom* (send *pot* :bottom))
  (send *pot-bottom* :translate #f(0 0 5) :world)

  (bottom-mix *pot* *pot-bottom* *n-list*)
  (send *irtviewer* :look-all
	(geo::make-bounding-box
	 (flatten (send-all (append *n-list* (send *pot* :bodies)) :vertices))))
  (send *viewer* :draw-objects)
  (x::window-main-one)
  (unix:usleep s-time)

  (push *n-list* *pot-list*)
  )


(defun onion-pan ()
  (send *irtviewer* :look-all
	(geo::make-bounding-box
	 (flatten (send-all (append *o-list* (send *pan* :bodies)) :vertices))))
  (send *viewer* :draw-objects)
  (x::window-main-one)
  (unix:usleep s-time)

  ;; onion-init for mix
  (dolist (x *o-list-3*)
    (if (send x :parent) (send (send x :parent) :dissoc x))
    (send x :move-to (send *pan* :copy-worldcoords) :world)
    (send x :rotate (deg2rad 90) :x)
    )
  
  (dolist (x *o-list-4*)
    (if (send x :parent) (send (send x :parent) :dissoc x))  
    (send x :move-to (send *pan* :copy-worldcoords) :world)
    (send x :rotate (deg2rad -90) :x)
    )

  (setq *pan-bottom* (send *pan* :bottom))

  (bottom-mix *pan* *pan-bottom* *o-list-3*)
  (bottom-mix *pan* *pan-bottom* *o-list-4*)
  (send *irtviewer* :look-all
	(geo::make-bounding-box
	 (flatten (send-all (append *o-list* (send *pan* :bodies)) :vertices))))
  (send *viewer* :draw-objects)
  (x::window-main-one)
  (unix:usleep s-time)

  ;; stir-fry
  (dolist (x *o-list*)
    (send x :set-color :BurlyWood)
    )
  (send *viewer* :draw-objects)
  (x::window-main-one)
  (unix:usleep s-time)
  )

(defun onion-pot ()
  (send *irtviewer* :look-all
	(geo::make-bounding-box
	 (flatten (send-all (append *o-list* (send *pot* :bodies)) :vertices))))
  (send *viewer* :draw-objects)
  (x::window-main-one)
  (unix:usleep s-time)
  
  ;; onion
  (dolist (x *o-list-3*)
    (if (send x :parent) (send (send x :parent) :dissoc x))
    (send x :move-to (send *pot* :copy-worldcoords) :world)
    (send x :rotate (deg2rad 90) :x)
    )

  (dolist (x *o-list-4*)
    (if (send x :parent) (send (send x :parent) :dissoc x))  
    (send x :move-to (send *pot* :copy-worldcoords) :world)
    (send x :rotate (deg2rad -90) :x)
    )  
  ;; pot codes
  (setq *pot-bottom* (send *pot* :bottom))
  (send *pot-bottom* :translate #f(0 0 5) :world)

  (bottom-mix *pot* *pot-bottom* *o-list-3*)
  (bottom-mix *pot* *pot-bottom* *o-list-4*)
  (send *irtviewer* :look-all
  	(geo::make-bounding-box
  	 (flatten (send-all (append *o-list* (send *pot* :bodies)) :vertices))))
  (send *viewer* :draw-objects)
  (x::window-main-one)
  (unix:usleep s-time)  

  (push *o-list-3* *pot-list*)
  (push *o-list-4* *pot-list*)

  )


(defun potato-pot ()
  (send *irtviewer* :look-all
	(geo::make-bounding-box
	 (flatten (send-all (append *p-list* (send *pot* :bodies)) :vertices))))
  (send *viewer* :draw-objects)
  (x::window-main-one)
  (unix:usleep s-time)
  
  ;; potato init for bottom mix
  (dolist (x *p-list-1*)
    (if (send x :parent) (send (send x :parent) :dissoc x))
    (send x :move-to (send *pot* :copy-worldcoords) :world)
    (send x :rotate (deg2rad -90) :y)
    )
  
  (dolist (x *p-list-2*)
    (if (send x :parent) (send (send x :parent) :dissoc x))
    (send x :move-to (send *pot* :copy-worldcoords) :world)
    (send x :rotate (deg2rad 90) :y)
    )

  ;; set pot-bottom
  (setq *pot-bottom* (send *pot* :bottom))
  (send *pot-bottom* :translate #f(0 0 5) :world)  
  
  (bottom-mix *pot* *pot-bottom* *p-list*)
  (send *irtviewer* :look-all
	(geo::make-bounding-box
	 (flatten (send-all (append *p-list* (send *pot* :bodies)) :vertices))))
  (send *viewer* :draw-objects)
  (x::window-main-one)
  (unix:usleep s-time)

  (push *p-list* *pot-list*)
  )

(defun carrot-pot ()
  (send *irtviewer* :look-all
	(geo::make-bounding-box
	 (flatten (send-all (append *c-list* (send *pot* :bodies)) :vertices))))
  (send *viewer* :draw-objects)
  (x::window-main-one)
  (unix:usleep s-time)
  
  ;; carrot
  (dolist (x *c-list-1*)
    (if (send x :parent) (send (send x :parent) :dissoc x))
    (send x :move-to (send *pot* :copy-worldcoords) :world)
    (send x :rotate (deg2rad -90) :x)
    )

  (dolist (x *c-list-2*)
    (if (send x :parent) (send (send x :parent) :dissoc x))  
    (send x :move-to (send *pot* :copy-worldcoords) :world)
    (send x :rotate (deg2rad 90) :x)
    )
  
  ;; set pot-bottom
  (setq *pot-bottom* (send *pot* :bottom))
  (send *pot-bottom* :translate #f(0 0 5) :world)  

  (bottom-mix *pot* *pot-bottom* *c-list-1*)
  (bottom-mix *pot* *pot-bottom* *c-list-2*)
  (send *irtviewer* :look-all
	(geo::make-bounding-box
	 (flatten (send-all (append *c-list* (send *pot* :bodies)) :vertices))))
  (send *viewer* :draw-objects)
  (x::window-main-one)
  (unix:usleep s-time)

  (push *c-list-1* *pot-list*)
  (push *c-list-2* *pot-list*)
  )



;;

(defun pour-water ()
  ;; sink
  (send *mcup* :move-to (send *water-point* :copy-worldcoords) :world)
  (send *mcup* :translate #f(0 0 -70) :world)
  (send *mcup* :copy-worldcoords)
  (send *irtviewer* :look-all
	(geo::make-bounding-box
	 (flatten (send-all (send *mcup* :bodies) :vertices))))
  (send *viewer* :draw-objects)
  (x::window-main-one)
  (unix:usleep s-time)

  ;; on water
  (setq *mcup-surface* (send *mcup* :water :surface 80))
  (send *mcup-surface* :set-color :cyan 0.5)
  (send *mcup* :assoc *mcup-surface*)

  (objects (append obj-list (list *water* *mcup-surface*)))
  (send *irtviewer* :look-all
	(geo::make-bounding-box
	 (flatten (send-all (append (send *mcup* :bodies) (list *water*)) :vertices))))
  (send *viewer* :draw-objects)
  (x::window-main-one)
  (unix:usleep s-time)

  ;; off water
  (objects (append obj-list (list *mcup-surface*)))
  (send *irtviewer* :look-all
  	(geo::make-bounding-box
  	 (flatten (send-all (append (send *mcup* :bodies) (list *water*)) :vertices))))
  (send *viewer* :draw-objects)
  (x::window-main-one)
  (unix:usleep s-time)

  ;; set move
  (send *mcup* :move-to (send *pot* :copy-worldcoords) :world)
  (send *mcup* :translate #f(0 130 200) :world)
  (send *mcup* :copy-worldcoords)
  (send *irtviewer* :look-all
  	(geo::make-bounding-box
  	 (flatten (send-all (append (send *mcup* :bodies) (send *pot* :bodies)) :vertices))))
  (send *viewer* :draw-objects)
  (x::window-main-one)
  (unix:usleep s-time)

  ;; pour water
  (send *mcup* :rotate (deg2rad 120) :x :world)
  (setq *water-current* (make-cylinder 10 120))
  (send *water-current* :set-color :cyan 0.5)
  (send *water-current* :move-to (send *pot* :copy-worldcoords) :world)
  (send *water-current* :translate #f(0 60 40) :world)
  (print (send *water-current* :copy-worldcoords))
  (setq *pot-surface* (send *pot* :water :surface 20))
  
  (send *pot-surface* :set-color :cyan 0.5)
  (objects (append obj-list (list *mcup-surface* *water-current* *pot-surface*)))
  (send *irtviewer* :look-all
  	(geo::make-bounding-box
  	 (flatten (send-all (append (send *mcup* :bodies) (send *pot* :bodies)) :vertices))))
  (send *viewer* :draw-objects)
  (x::window-main-one)
  (unix:usleep s-time)

  ;; set-move
  (setq *pot-surface* (send *pot* :water :surface 60))  
  (send *pot-surface* :set-color :cyan 0.5)

  (if (not (null *pot-list*))
      (dolist (x *pot-list*)
	(water-mix *pot* *pot-surface* x)))
  
  (send *mcup* :move-to (make-coords :pos #f(980 -330 845)) :world)
  (objects (append obj-list (list *pot-surface*)))
  (send *irtviewer* :look-all
  	(geo::make-bounding-box
  	 (flatten (send-all (send *pot* :bodies) :vertices))))
  (send *viewer* :draw-objects)
  (x::window-main-one)
  (unix:usleep s-time)    
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
  (x::window-main-one)
  (unix:usleep s-time)

  (send r1 :move-to (send *pot* :copy-worldcoords) :world)
  (send r1 :translate #f(10 40 70) :world)

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
  (x::window-main-one)
  (unix:usleep s-time)
  

  
  ;; change curry
  (if *pot-surface*
      (send *pot-surface* :set-color :Sienna))
  (if (boundp '*r*)
      (send *r* :translate #f(0 0 -42) :world))
  
  (send *irtviewer* :look-all
  	(geo::make-bounding-box
  	 (flatten (send-all (send *pot* :bodies) :vertices))))
  (send *viewer* :draw-objects)
  (x::window-main-one)
  (unix:usleep s-time)  
  )


(defun add-stew-mix ()
  ;; set roux
  (send *irtviewer* :look-all
	(geo::make-bounding-box
  	 (flatten (send-all (append (send *mix* :bodies) (send *pot* :bodies)) :vertices))))
  (send *viewer* :draw-objects)
  (x::window-main-one)
  (unix:usleep s-time)
  
  ;; change curry
  (if *pot-surface*
      (send *pot-surface* :set-color :Cornsilk))
  (if (boundp '*o*)
      (send *o* :translate #f(0 0 -42) :world))
  (if (boundp '*r*)
      (send *r* :translate #f(0 0 -42) :world))
  (send *irtviewer* :look-all
  	(geo::make-bounding-box
  	 (flatten (send-all (send *pot* :bodies) :vertices))))
  (send *viewer* :draw-objects)
  (x::window-main-one)
  (unix:usleep s-time)
  )

