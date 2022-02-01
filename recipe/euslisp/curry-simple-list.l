;; カレーの作り方のリスト表現?

;; 人参を輪切りに切る．
;; じゃがいもを４等分に切る．
;; 玉ねぎを薄切りに切る．
;; 玉ねぎを炒める．
;; 肉を炒める．
;; 水と人参とじゃがいもを鍋に入れて煮込む． (ここは分解して表現することになる)
;; カレールーを入れて煮込む．（ここも）

(setq *curry-simple-list* (list
                           "cut carrot slices"
                           "cut potato four-parts"
                           "cut onion slice"
                           "fry onion"
                           "fry meat"
                           "put water into pot"
                           "put carrot into pot"
                           "put potato into pot"
                           "stew pot"
                           "put roux into pot"
                           "stew pot"
                           ))
