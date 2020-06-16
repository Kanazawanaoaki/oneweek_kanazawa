(load "cook-b2-func.l")

;; define init funcs

(defun init-curry ()
  (curry-init)

  (warn "~%please run (nomal-curry) or (easy-curry) ~%")
  )

(defun init-stew ()
  (stew-init)

  (warn "~%please run (nomal-stew)~%")
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
  (onion-wash) ;; 玉ねぎを洗う
  (onion-peel) ;; 玉ねぎの皮を剥く
  (onion-cut) ;; 玉ねぎを薄切りする
  (carrot-wash) ;; 人参を洗う
  (carrot-peel) ;; 人参の皮を剥く
  (carrot-cut) ;; 人参を薄切りする
  (potato-wash) ;; じゃがいもを洗う
  (potato-peel) ;; じゃがいもの皮を剥く
  (potato-cut) ;; じゃがいもを一口大に切る
  (onion-stir-fry) ;; 玉ねぎを炒める
  (niku-stir-fry) ;; 肉を炒める
  (carrot-pot) ;; 人参を鍋に加える,少し炒める
  (pour-water) ;; 水を加える,煮込む
  (potato-pot) ;; じゃがいもを鍋に加える,煮込む
  (put-curry-roux) ;; カレールーを加える,煮込む

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
  (onion-wash) ;; 玉ねぎを洗う
  (onion-peel) ;; 玉ねぎの皮を剥く
  (onion-cut) ;; 玉ねぎを薄切りする
  (carrot-wash) ;; 人参を洗う
  (carrot-peel) ;; 人参の皮を剥く
  (carrot-cut) ;; 人参を薄切りする
  (potato-wash) ;; じゃがいもを洗う
  (potato-peel) ;; じゃがいもの皮を剥く
  (potato-cut) ;; じゃがいもを一口大に切る
  (niku-stir-fry) ;; 肉を炒める
  (onion-pot) ;; 玉ねぎを加える
  (potato-pot) ;; じゃがいもを鍋に加える
  (carrot-pot) ;; 人参を鍋に加える,少し炒める
  (pour-water) ;; 水を加える,煮込む
  (put-curry-roux) ;; カレールーを加える,煮込む

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
  ;; (onion-wash) ;; 玉ねぎを洗う
  ;; (onion-peel) ;; 玉ねぎの皮を剥く
  ;; (onion-cut) ;; 玉ねぎを薄切りする
  ;; (carrot-wash) ;; 人参を洗う
  ;; (carrot-peel) ;; 人参の皮を剥く
  ;; (carrot-cut) ;; 人参を薄切りする
  ;; (potato-wash) ;; じゃがいもを洗う
  ;; (potato-peel) ;; じゃがいもの皮を剥く
  ;; (potato-cut) ;; じゃがいもを一口大に切る

  (warn "WIP!~%")
  )
  


(defun nomal-stew ()
  ;; ;; シチュー用の初期準備
  ;; (stew-init)

  ;; 時間がかかるので先にcutモードにしておく
  (send *onion* :cut)

  ;; set sleep time
  ;; (setq s-time 1000000)
  (setq s-time 500000)

  ;; 普通のシチューのレシピ
  (onion-wash) ;; 玉ねぎを洗う
  (onion-peel) ;; 玉ねぎの皮を剥く
  (onion-cut) ;; 玉ねぎを薄切りする
  (carrot-wash) ;; 人参を洗う
  (carrot-peel) ;; 人参の皮を剥く
  (carrot-cut) ;; 人参を薄切りする
  (potato-wash) ;; じゃがいもを洗う
  (potato-peel) ;; じゃがいもの皮を剥く
  (potato-cut) ;; じゃがいもを一口大に切る
  (niku-stir-fry) ;; 肉を炒める
  (carrot-pot) ;; 人参を鍋に加える
  (potato-pot) ;; じゃがいもを鍋に加える
  (onion-pot) ;; 玉ねぎを鍋に加える
  (pour-water) ;; 水を加える,煮込む
  (add-stew-mix) ;; カレールーを加える,煮込む
  ;; (add-milk) ;; 牛乳を加える
  
  (warn "WIP!~%")

  (init)
  )
  
(defun init ()
  (warn "~%if you want to make curry with pot, please run (init-curry) first and then run (nomal-curry) or (easy-curry) ~%")
  (warn "You can also make stew by running (init-stew) and then run (nomal-stew) ~%")

  )



(init)
