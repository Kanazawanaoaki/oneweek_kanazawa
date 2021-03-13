(defun look-all ()
  (send *irtviewer* :look-all
        (send (geo::make-bounding-box
               (flatten (send-all (send *robot* :bodies) :vertices))) :grow 0.3)))

(defun init ()
  (unless (boundp '*h7*)
    (load "models/h7-robot.l")
    (setq *robot* (h7)))
  (unless (boundp '*room*)
    (load "models/room73b2-scene.l")
    (setq *room* (room73b2))
    (setq *kettle* (send *room* :object "room73b2-kettle"))
    (setq *kettle-orig-coords* (send *kettle* :copy-worldcoords)))
  (if (send *kettle* :parent) (send (send *kettle* :parent) :dissoc *kettle*))
  (send *kettle* :newcoords (send *kettle-orig-coords* :copy-worldcoords))
  ;;
  (objects (list *robot* *room*))
  (send *robot* :reset-pose)
  (send *robot* :move-to (send *room* :spot "init-spot") :world)
  (send *robot* :locate #f(0 0 550))
  (look-all)
  )

(defun move-to-cook-spot ()
  (send *robot* :move-to (send *room* :spot "cook-spot") :world)
  (send *robot* :locate #f(0 0 550))
  (look-all))

(defun reach-kettle ()
  (send *robot* :reset-pose)
  (send *robot* :head :look-at (send *kettle* :worldpos))
  (send *robot* :larm :inverse-kinematics
        (car (send *kettle* :handle))
        :link-list (send *robot* :link-list (send *robot* :larm :end-coords :parent))
        :move-target (send *robot* :larm :end-coords)
        :rotation-axis :z
        :p-limit 10 :r-limit 0.05 ;; slow down
        :debug-view t)
  )

(defun grab-kettle ()
  (send *robot* :larm :end-coords :assoc *kettle*)
  (send *robot* :larm :move-end-pos #f(-50 0 50) :world
        :p-limit 10 :r-limit 0.05 ;; slow down
        :debug-view t :look-at-target t))

(defun move-to-table ()
  (send *robot* :move-to (send *room* :spot "coe-spot") :world)
  (send *robot* :locate #f(0 0 550))
  (look-all))

(defun release-kettle ()
  (send *robot* :larm :move-end-pos #f(0 0 -50) :world
        :p-limit 10 :r-limit 0.05 ;; slow down
        :debug-view t :look-at-target t)
  (send *robot* :larm :end-coords :dissoc *kettle*)
  (send *robot* :reset-pose))


;; do demo
(format t ";; run kettle demo by command
(init)
(move-to-cook-spot)
(reach-kettle)
(grab-kettle)
(move-to-table)
(release-kettle))
")
