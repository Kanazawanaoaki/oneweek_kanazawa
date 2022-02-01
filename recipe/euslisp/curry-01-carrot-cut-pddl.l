#!/usr/bin/env roseus

(load "package://pddl_planner/src/pddl-result-graph.l")
(load "package://pddl_planner/src/eus-pddl-client.l")

;;
;; problem
;;
(setq *problem* (instance pddl-problem :init :name 'curry_01_cut_carrot :domain 'kanazawa_curry_carrot))

;;使用する変数の宣言
(send *problem* :objects
      '(
        (CARROT . object) ;; 食材？野菜？
        (KNIFE . tool)
        (PEELER . tool)
        (BOWL . tool) ;; 器？
        (BOARD . tool) ;; 器？
        (DISH . tool) ;; 器？
        (WATER-FAUCET . tool)
        (SINK-SPOT . spot)
        (KITCHEN-SPOT . spot)
        ))

;;初期条件
(send *problem* :initial-condition
      '(
        (ON CARROT DISH)
        (AT KITCHEN-SPOT)
        ))

;;終了条件
(send *problem* :goal-condition
      '(
        (CUT CARROT)
        (IN CARROT BOWL)
        ))

;;
;; domain
;;
(setq *domain* (instance pddl-domain :init :name 'kanazawa_curry_carrot))
(send *domain* :requirements '(:typing))
(send *domain* :types '(object spot tool))
;; (send *domain* :constants '(WATER POT IH - object))
(send *domain* :predicates '(
                             (CUT ?obj - object)
                             (WATER ?obj - object)
                             (PEEL ?obj - object)
                             (ON ?obj - object ?tool - tool)
                             (IN ?obj - object ?tool - tool)
                             (ONHAND ?obj - object)
                             (AT ?spot - spot)
                             
                             ;; (ON ?obj0 ?obj1 - object)
                             ;; (IN ?obj0 ?obj1 - object)
                             ;; (IH-OFF ?obj - object)
                             ;; (IH-ON ?obj - object)
                             ;; (BOILED ?obj - object)
                             ))

;;making action
(setq *actions*
      (list
       (instance pddl-action :init
                 :name "grasp"
                 :parameters '((?OBJECT object))
                 :precondition '((NOT (IN WATER ?OBJECT))
                                 )
                 :effect '((IN WATER ?OBJECT)
                           ))
       (instance pddl-action :init
                 :name "heat-ih"
                 :parameters '()
                 :precondition '((IH-OFF IH)
                                 )
                 :effect '((IH-ON IH)
                           (NOT (IH-OFF IH))
                           ))
       (instance pddl-action :init
                 :name "boil-water"
                 :parameters '()
                 :precondition '((NOT (BOILED WATER))
                                 (IN WATER POT)
                                 (ON POT IH)
                                 (IH-ON IH)
                                 )
                 :effect '((BOILED WATER)
                           ))
       (instance pddl-action :init
                 :name "stop-ih"
                 :parameters '()
                 :precondition '((IH-ON IH)
                                 )
                 :effect '((IH-OFF IH)
                           (NOT (IH-ON IH))
                           ))
       ))

;;add action to domain
(dolist (act *actions*)
  (send *domain* :add :action act))

;;
;; solve planning
;;
(pprint (setq *result* (solve-pddl-planning *domain* *problem*)))

(setq gr (make-graph-from-pddl-results (list *result*) :node-name :pprint))

(send gr :write-to-pdf "kanazaw_ih.pdf")

(when (ros::get-param "~display_graph" "true")
  (piped-fork "xdg-open kanazaw_ih.pdf"))

(when (string= "__log:=" (subseq (car (last lisp::*eustop-argument*)) 0 7))
  (ros::exit))

