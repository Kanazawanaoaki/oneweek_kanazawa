(load "update-func.l")

;; define init funcs

(defun init-curry ()
  (curry-init)

  (warn "~%please run (nomal-curry) or (easy-curry) ~%")
  )

(defun init-stew ()
  (stew-init)

  (warn "~%please run (nomal-stew) or (easy-curry)~%")
  )


;; 普通のカレーの作り方の例（だと僕が思うレシピ）
(defun nomal-curry ()
  ;; ;; カレー用の初期準備
  ;; (curry-init)

  ;; 時間がかかるので先にcutモードにしておく
  (send *onion* :cut)

  ;; set sleep time
  ;; (setq s-time 1000000)
  (setq s-time 500000)

  ;; 普通のカレーのレシピ
  (onion-slice) ;; 玉ねぎ薄切りにする
  (carrot-half-moon) ;;人参を半月切りにする
  (potato-bite-size) ;;じゃがいもを一口大にする
  (niku-pan-test) ;; 肉を炒める
  (niku-pot-test) ;; 肉を加える
  (onion-pan-test) ;; 玉ねぎを炒める
  (onion-pot-test) ;; 玉ねぎを加える
  (potato-pot-test) ;; じゃがいもを加える
  (carrot-pot-test) ;; 人参を加える
  (pour-water) ;; 水を加える
  (put-curry-roux) ;; カレールーを加える

  (init)
  )



(defun easy-curry ()
  ;; ;; カレー用の初期準備
  ;; (curry-init)

  ;; 時間がかかるので先にcutモードにしておく
  (send *onion* :cut)

  ;; set sleep time
  ;; (setq s-time 1000000)
  (setq s-time 500000)

  ;; 簡単なカレーのレシピ
  (onion-slice) ;; 玉ねぎ薄切りにする
  (carrot-half-moon) ;;人参を半月切りにする
  (potato-bite-size) ;;じゃがいもを一口大にする
  (niku-pan-test) ;; 肉を炒める
  (niku-pot-test) ;; 肉を加える
  (onion-pot-test) ;; 玉ねぎを加える
  (potato-pot-test) ;; じゃがいもを加える
  (carrot-pot-test) ;; 人参を加える
  (pour-water) ;; 水を加える
  (put-curry-roux) ;; カレールーを加える
  
  (init)
  ) 


(defun curry-with-slow-cooker ()
  ;; ;; スロークッカー有りのカレー用の初期準備
  ;; (curry-with-slow-cooker-init)

  ;; ;; 時間がかかるので先にcutモードにしておく
  ;; (send *onion* :cut)

  ;; ;; set sleep time
  ;; ;; (setq s-time 1000000)
  ;; (setq s-time 500000)

  ;; ;; 普通のカレーのレシピ
  ;; (onion-slice) ;; 玉ねぎ薄切りにする
  ;; (carrot-half-moon) ;;人参を半月切りにする
  ;; (potato-bite-size) ;;じゃがいもを一口大にする

  (warn "WIP!~%")
  )
  

(defun easy-stew ()
  ;; ;; シチュー用の初期準備
  ;; (stew-init)

  ;; 時間がかかるので先にcutモードにしておく
  (send *onion* :cut)

  ;; set sleep time
  ;; (setq s-time 1000000)
  (setq s-time 500000)

  ;; 普通のシチューのレシピ
  (onion-slice) ;; 玉ねぎ薄切りにする
  (carrot-half-moon) ;;人参を半月切りにする
  (potato-bite-size) ;;じゃがいもを一口大にする
  (niku-pan-test) ;; 肉を炒める
  (niku-pot-test) ;; 肉を加える
  (onion-pot-test) ;; 玉ねぎを加える
  (potato-pot-test) ;; じゃがいもを加える
  (carrot-pot-test) ;; 人参を加える
  (pour-water) ;; 水を加える
  (add-stew-mix) ;; シチューミックスを加える,煮込む
  ;; (add-milk) ;; 牛乳を加える
  
  (warn "WIP!~%")

  (init)
  )


(defun nomal-stew ()
  ;; ;; シチュー用の初期準備
  ;; (stew-init)

  ;; 時間がかかるので先にcutモードにしておく
  (send *onion* :wedges)

  ;; set sleep time
  ;; (setq s-time 1000000)
  (setq s-time 500000)

  ;; 普通のシチューのレシピ
  (onion-wedges) ;; 玉ねぎをくし切りする
  (carrot-random) ;;人参を半月切りにする
  (potato-bite-size) ;;じゃがいもを一口大にする
  (niku-pan-test) ;; 肉を炒める
  (niku-pot-test) ;; 肉を加える
  (onion-pot-test) ;; 玉ねぎを加える
  (potato-pot-test) ;; じゃがいもを加える
  (carrot-pot-test) ;; 人参を加える
  (pour-water) ;; 水を加える
  (add-stew-mix) ;; シチューミックスを加える,煮込む
  ;; (add-milk) ;; 牛乳を加える
  
  (warn "WIP!~%")

  (init)
  )


(defun init ()
  (warn "~%if you want to make curry with pot, please run (init-curry) first and then run (nomal-curry) or (easy-curry) ~%")
  (warn "You can also make stew by running (init-stew) and then run (nomal-stew) or (easy-stew) ~%")

  )


(init)
