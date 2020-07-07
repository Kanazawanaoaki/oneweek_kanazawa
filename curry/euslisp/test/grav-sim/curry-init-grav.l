(defun grav-sim-func (abody floor)
  (setq t-flag nil)
  (until t-flag
	 (send abody :translate #f(0 0 -1) :world)
	 (send *viewer* :draw-objects)	 
	 (if (= (pqp-collision-check abody floor) 1)
	     (setq t-flag t))
	 )
  )

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

  ;; set ボウル
  (load "../model/bowl-update-model.l")
  (setq *bowl1* (bowl))
  (send *bowl1* :locate #f(860 100 825))

  (setq *bowl2* (bowl))
  (send *bowl2* :locate #f(860 245 825))

  (setq *bowl3* (bowl))
  (send *bowl3* :locate #f(720 250 825))

  ;; set onion
  (load "../model/onion-test-model.l")
  (setq *onion* (onion))
  (send *onion* :locate #f(860 -150 845))

  ;; set carrot
  (load "../model/carrot-test-model.l")
  (setq *carrot* (carrot))
  (send *carrot* :locate #f(900 10 845))

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

  ;; def flag
  (setq o-place nil)
  (setq c-place nil)
  (setq p-place nil)
  (setq n-place nil)
  
  ;;defin object list for visialize
  (setq obj-list (list *kitchen* *knife* *peeler* *cutting-board* *pot* *pan* *bowl1* *bowl2* *bowl3* *onion* *carrot* *potato* *niku* *trash-box* *mcup* *roux*))
  ;; (setq obj-list (list *kitchen* *knife* *peeler* *cutting-board* *pot* *pan* *onion* *carrot* *potato* *niku* *trash-box* *mcup* *roux* *arrow*))

  (objects obj-list)
  )



(curry-init)


