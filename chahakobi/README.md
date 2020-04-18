# 茶運びロボット

PR2でお茶を作って持ってきてくれるデモを作る。
お湯をわかせて注げれば、お茶だけでなく、コーヒー、カップラーメンにも対応できるはず。


## 作るデモ
### IRT viewer  
まずIRT viewerで作る、認識とかもすべてわかっている状態。シミュレーションでも無い。
```
roseus irt-demo.l
```

###  kinematics simulater  
運動学シミュレータを使って実機と同じeusのインターフェースでデモを作る。
```
roseus kinematics-demo.l
```

### Gazebo  
物理シミュレーションが大事になりそうな部分について、Gazeboを使ってシミュレーションを行う。

## デモの流れ

- コンロまで行く (go-to-cook)
- やかんを持つ (pick-up-kettle)
- シンクまで移動する (go-to-sink)
- やかんに水を入れる (pour-water)
- コンロの前に行く (go-to-cook2)
- やかんをコンロに置く (put-kettle)
- コンロをつける (put-on-stove)
- お茶を用意する (prepare-tea)
- お湯が湧くのを待つ (wait-boil)
- コンロを消す (turn-off-stove)
- やかんを持つ (pick-up-kettle2)
- お湯を注ぐ (pour-hot-water)
- やかんを置く (put-kettle2)
- コップを戻す (pick-up-kettle2)
- 机まで持っていく (go-to-desk)

一つの動作を一つの関数にしてあり、一つ実行すると次に実行する関数がlogにでるようにしてある。  

また、
```lisp
(exec-all)
```
ですべての動作を実行。
```lisp
(now-devel)
```
で今作っている部分の手前までを実行できる。  

## 考えられる改善
最初にお茶やコーヒー、カップラーメンなどを用意した方が良いかもしれない。  
eusなどのモデルを修正してやかんの蓋を取れるようにする？  
お茶やコーヒーの場所をはじめから知っておくべき？そこに無かったら？もし在庫が切れていたら？  
最初に、やかんの向きお湯とかが入っているのかどうかとかやかんが熱く無いかとか確認する。

## 最新の情報
基本的に[こちら](https://github.com/Kanazawanaoaki/jsk_demos/tree/kanazawa-ow/jsk_2020_04_chahakobi)に移行する。