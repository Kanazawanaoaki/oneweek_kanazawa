(setq p-list (list (float-vector 0 0 100) (float-vector 30 0 90) (float-vector 10 0 -90) (float-vector 0 0 -100)))
(setq *hoge* (make-solid-of-revolution p-list))

(send *hoge* :rotate (deg2rad 90) :x)

(send *hoge* :set-color :orangered)

(objects (list *hoge*))
