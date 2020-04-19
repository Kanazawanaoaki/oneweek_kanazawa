# model

モデルの変換等についてまとめる。
- eusの幾何モデルの作り方  
- eusモデルからurdf
- STLファイルからeusモデル

## eusの幾何モデルの作り方  
euslispには幾何モデルを作る関数が用意されている。  
詳しくは[jmanual](https://raw.githubusercontent.com/euslisp/jskeus/master/doc/jmanual.pdf)を参照。　　

直方体を作る。  
```lisp
(setq *cube* (make-cube 200 350 10))
```

回転立体を作る。
```lisp
(setq *kaiten* (make-solid-of-revolution (list #f(0 0 10) #f(100 0 10) #f( 120 0 110) #f(130 0 110) #f(110 0 5) #f(105 0 0) #f(0 0 0))))  
```

球を作る。
```lisp
(setq *sphere* (make-sphere 70))
```

円柱を作る。
```lisp
(setq *cylinder* (make-cylinder 35 5))
```

## eusモデルからurdf
eusで作った幾何モデルをgazeboなどで使えるurdfファイルに変換する。  
[eusurdf](https://github.com/jsk-ros-pkg/jsk_model_tools/tree/master/eusurdf)を使って変換を行う。  

eusurdfのREADMEに従っても良いし、
```lisp
(load "cooking-pot.l")
(load "package://eusurdf/euslisp/convert-eus-to-urdf.l")
(irteus2urdf-for-gazebo (cooking-pot) :name "cooking-pot" )
```
などのようにしても作れる。  

/opt/ros/以下のものだとファイルの書き込み権限などで上手く実行出来なかったので、git cloneしてきて使った。  

## STLファイルからeusモデル
STL形式のCADデータからeusのモデルを作る。
https://github.com/jsk-ros-pkg/jsk_model_tools#convert-from-cad-manually  
を使って変換できる。  

Convert1. STLファイルが既にあるのなら大丈夫  
Convert2. 上記READMEのURDFファイルを、STLファイルへのパス部分だけ書き換えれば良い  
Convert3. URDFファイルをcolladaファイルにコマンドですが、そのまま使える  
Convert4. コマンドが2つ書かれていますが、fixed model versionの方で大丈夫  

以上の手順で、my_model.lが生成される  
最後に、Visualize3. の手順に従ってIRTViewerで表示すれば、正しくモデルの変換が行われたか確認できる。  
READMEでは(objects (list (my_model)))となっているが、(objects (list (my_model_name)))だと上手く行く。  
