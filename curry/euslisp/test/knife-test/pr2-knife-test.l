(load "package://pr2eus/pr2.l")
(setq *pr2* (pr2))

(load "knife-new-attention.l")
(setq *knife* (knife))

(send *knife* :newcoords (send (send *pr2* :rarm :end-coords) :copy-worldcoords))
(send *knife* :translate #f(7 0 0))
(send *knife* :rotate (deg2rad 90) :x)

(objects (list *pr2* *knife*))
