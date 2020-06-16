(load "curry-b2-func.l")

;; 普通のカレーの作り方の例（だと僕が思うレシピ）
(defun nomal-curry ()
  ;; カレー用の初期準備
  (init)

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
  ;; (niku-stir-fry) ;; 肉を炒める
  (carrot-pot) ;; 人参を鍋に加える
  (potato-pot) ;; じゃがいもを鍋に加える
  (onion-pot) ;; 玉ねぎを鍋に加える
  (pour-water) ;; 水を加える,煮込む
  (add-stew-mix) ;; カレールーを加える,煮込む
  (add-milk) ;; 牛乳を加える
  
  (warn "WIP!~%")

  )
  

(warn "you can also run (nomal-curry),(curry-with-slow-cooker) or (nomal-stew)~%")
