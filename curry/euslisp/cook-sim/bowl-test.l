(load "bowl-func-tmp.l")


;; test
(defun test ()
  (curry-init)


  ;; (send *onion* :cut)

  ;; ;; set sleep time
  ;; ;; (setq s-time 1000000)
  ;; (setq s-time 0)

  ;; ;; 普通のカレーのレシピ


  ;; (onion-slice);;玉ねぎを薄切りに


  (send *onion* :wedges)

  ;; set sleep time
  ;; (setq s-time 1000000)
  ;; (setq s-time 500000)
  (setq s-time 0)

  ;; 普通のシチューのレシピ
  
  (onion-wedges);;玉ねぎをくし切りに

  
  (setq s-time 1000000)


  (onion-pan)
  (onion-pot)

  
  )

(test)



;; define init funcs

(defun init-curry ()
  (curry-init)

  (warn "~%please run (nomal-curry) , (my-curry) or (easy-curry) ~%")
  )

(defun init-stew ()
  (stew-init)

  (warn "~%please run (nomal-stew) or (easy-stew)~%")
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


  (onion-slice);;玉ねぎを薄切りに
  (carrot-random);;人参を乱切りに
  (potato-bite-size);;じゃがいもを一口大に
  (niku-pan);;肉を炒める
  (niku-pot);;肉を鍋に
  (onion-pan);;玉ねぎを炒める
  (onion-pot);;玉ねぎを鍋に
  (potato-pot);;じゃがいもを鍋に
  (carrot-pot);;人参を鍋に
  (pour-water);;水を加え,炒める
  (put-curry-roux);;カレールーを加える

  


  (init)
  )

;; 我が家のカレーの作り方の例（だと僕が思うレシピ）
(defun my-curry ()
  ;; ;; カレー用の初期準備
  ;; (curry-init)

  ;; 時間がかかるので先にcutモードにしておく
  (send *onion* :cut)

  ;; set sleep time
  ;; (setq s-time 1000000)
  (setq s-time 500000)

  ;; 我が家のカレーのレシピ
  

  (onion-slice);;玉ねぎを薄切りに
  (carrot-random);;人参を乱切りに
  (potato-bite-size);;じゃがいもを一口大に
  (niku-pan);;肉を炒める
  (niku-pot);;肉を鍋に
  (onion-pan);;玉ねぎを炒める
  (onion-pot);;玉ねぎを鍋に
  (carrot-pot);;人参を鍋に
  (pour-water);;水を加え,炒める
  (potato-pot);;じゃがいもを鍋に
  (put-curry-roux);;カレールーを加える

  


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

  
  (onion-slice);;玉ねぎを薄切りに
  (carrot-half-moon);;人参を半月切りに
  (potato-bite-size);;じゃがいもを一口大に
  (niku-pan);;肉を炒める
  (niku-pot);;肉を鍋に
  (onion-pot);;玉ねぎを鍋に
  (potato-pot);;じゃがいもを鍋に
  (carrot-pot);;人参を鍋に
  (pour-water);;水を加え,煮込む
  (put-curry-roux);;カレールーを加える


  
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

  ;; 簡単なシチューのレシピ
  (onion-slice) ;; 玉ねぎ薄切りにする
  (carrot-half-moon) ;;人参を半月切りにする
  (potato-bite-size) ;;じゃがいもを一口大にする
  (niku-pan) ;; 肉を炒める
  (niku-pot) ;; 肉を加える
  (onion-pot) ;; 玉ねぎを加える
  (potato-pot) ;; じゃがいもを加える
  (carrot-pot) ;; 人参を加える
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
  
  (onion-wedges);;玉ねぎをくし切りに
  (carrot-random);;人参を乱切りに
  (potato-bite-size);;じゃがいもを一口大に
  (niku-pan);;肉を炒める
  (niku-pot);;肉を鍋に
  (onion-pot);;玉ねぎを鍋に
  (potato-pot);;じゃがいもを鍋に
  (carrot-pot);;人参を鍋に
  (pour-water);;水を加え,煮込む
  (add-stew-mix);;シチューミックスを加える

  
  
  ;; (add-milk) ;; 牛乳を加える
  
  (warn "WIP!~%")

  (init)
  )


(defun init ()
  (warn "~%if you want to make curry with pot, please run (init-curry) first~%")
  (warn "You can also make stew by running (init-stew) first~%")
  )


(init)
