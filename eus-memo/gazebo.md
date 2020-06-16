# Gazebo

gazeboを使うためにやったことなどをまとめていく。  
- modelを作る  
- worldを作る  
- move_baseなどを立ち上げる

## modelを作る
gazeboのモデルはsdf形式を使用するらしい。urdfでも大丈夫そう？  
### eusモデルからurdf
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
bodyset-linkではおそらく駄目で、cascaded-linkにしておく必要がある。出来たフォルダを移動して使う。

作ったmodelを使えるようにするには、package.xmlに
```xml
<exec_depend>gazebo_ros</exec_depend>

<!-- The export tag contains other, unspecified, tags -->
<export>
 <!-- Other tools can request additional information be placed here -->
 <gazebo_ros gazebo_model_path="${prefix}/models" />
</export>
```
を追加する必要がある。

## worldを作る。
https://github.com/jsk-ros-pkg/jsk_pr2eus/blob/master/pr2eus_tutorials/worlds/tabletop.world こんな感じでworldファイルを作る。  
そのworldファイルをを呼ぶlaunchを作る。
https://github.com/jsk-ros-pkg/jsk_pr2eus/blob/9ca0a026a161a2e6ae0b0f55d7d355d7c9ea8870/pr2eus_tutorials/launch/gazebo/pr2_tabletop_scene.launch  

## move_baseなどを立ち上げる
https://github.com/jsk-ros-pkg/jsk_pr2eus/blob/master/pr2eus/test/pr2-ri-test.launch などのように色々なものを立ち上げることが出来る。  
move_baseを立ち上げる事で:go-posやnavigationを行うことができる。  
