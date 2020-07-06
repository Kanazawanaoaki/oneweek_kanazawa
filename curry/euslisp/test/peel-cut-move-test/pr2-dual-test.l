(load "package://pr2eus/pr2-interface.l")
(pr2-init)

(setq *pr2* (pr2))

(setq *pr2-mockup* (pr2))
(send *pr2-mockup* :translate #f(1000 1000 0))

(objects (list *pr2-mockup* *pr2*))
