# 認識系

[jsk_recognition](https://jsk-docs.readthedocs.io/projects/jsk_recognition/en/latest/index.html)に色々使えるプログラムがあるのでこれを使うのが良い。  

サンプルを実行するためのrosbagなどのデータを重いのでcatkin build時にダウンロードされるようになっている。aptで入れているものだとそのデータ入れるのが面倒なので、jsk_recognitionをgit cloneしてsourceで入れるのが良い。  

jsk_recognitionには
- jsk_perception
- jsk_pcl_ros
- jsk_pcl_ros_utils  
等がある。jsk_perceptionはカメラなどの２次元画像ベースの認識で、jsk_pcl_rosとjsk_pcl_ros_utilsはpoint cloudベースの認識ライブラリである[pcl_ros](http://wiki.ros.org/pcl_ros)のJSK版。  

## 色認識からbounding box
ゼミで扱った。色認識からbounding boxを出すlaunchファイル。
https://github.com/jsk-ros-pkg/jsk_demos/blob/master/jsk_2019_10_semi/launch/hsi_color_filter.launch

[HSIColorFilter](https://jsk-docs.readthedocs.io/projects/jsk_recognition/en/latest/jsk_pcl_ros/nodes/hsi_color_filter.html)を使って指定した範囲のHSI値のpoint cloudのみを抽出する。  

HSIの値は、
```
rosrun rqt_reconfigure rqt_reconfigur
```
でGUIでいじることが出来る。RvizでPointCloud2やBoundingBoxArrayを見ることでフィルタの結果をみながら調整する。  

HSIフィルタを通した点群について、[EuclideanClustering](https://jsk-docs.readthedocs.io/projects/jsk_recognition/en/latest/jsk_pcl_ros/nodes/euclidean_clustering.html)をすることで、ユークリッド距離を使ってクラスタリングする。  

その結果に対して、[ClusterPointIndicesDecomposer](https://jsk-docs.readthedocs.io/projects/jsk_recognition/en/latest/jsk_pcl_ros/nodes/cluster_point_indices_decomposer.html)をすることでbounding boxを出している。  
クラスタリングした結果を用いて、それぞれのクラスターのpoint cloudとか重心位置とかを出すようになっている。  

## 画像からのテンプレートマッチング
ゼミで扱った。入力画像とテンプレート画像のSIFT特徴量を照合してテンプレート画像と一致する部分の位置姿勢を取得出来る。  
https://github.com/jsk-ros-pkg/jsk_demos/blob/master/jsk_2019_10_semi/launch/point_pose_extractor_socks.launch  

[PointPoseExtractor](https://jsk-docs.readthedocs.io/projects/jsk_recognition/en/latest/jsk_perception/nodes/point_pose_extractor.html)を使っている。  

## PointCloudのマッチング
[ICPRegistration](https://jsk-docs.readthedocs.io/projects/jsk_recognition/en/latest/jsk_pcl_ros/nodes/icp_registration.html)を使ってReferenece PointCloudと入力のPointCloudをICP (Iterative Closest Point)で位置姿勢を整合させる。  

まず[PointCloudToPCD](https://jsk-docs.readthedocs.io/projects/jsk_recognition/en/latest/jsk_pcl_ros_utils/nodes/pointcloud_to_pcd.html)をつかって点群のトピックをpcdファイルに保存した。  
そのpcdファイルにたいして、[CloudCompare](http://www.danielgm.net/cc/)という点群処理ソフトでやかんの部分だけを切り出して保存した。  
もしくは、保存するときに[AttentionClipper](https://jsk-docs.readthedocs.io/projects/jsk_recognition/en/latest/jsk_pcl_ros/nodes/attention_clipper.html)と[ExtractIndices](https://jsk-docs.readthedocs.io/projects/jsk_recognition/en/latest/jsk_pcl_ros/nodes/extract_indices.html)を使って点群を切り出したものを使うなどする。  
保存したpcdファイルからpcd_to_pointcloudでPointCloudを出力する。  
そのPointCloudをReferenceとして使用してICPを行う。

しかし、ICPはlocalな手法で初期姿勢が大きくことなると利用出来ない。  

## ロボットが掴んでいる物の点群を獲得する
ロボットが掴んでいる物体の点群を獲得する。これを使って物体のeusモデルを作成したい。

### ロボットリンクの除去
[robot_self_filter](http://wiki.ros.org/robot_self_filter)や[robot_self_filter_color](http://wiki.ros.org/robot_self_filter_color)を使うことでロボットリンクを除去した点群を獲得することが出来る。

### グリッパ近くを切り出す
[AttentionClipper](https://jsk-docs.readthedocs.io/projects/jsk_recognition/en/latest/jsk_pcl_ros/nodes/attention_clipper.html)と[ExtractIndices](https://jsk-docs.readthedocs.io/projects/jsk_recognition/en/latest/jsk_pcl_ros/nodes/extract_indices.html)を使って点群を切り出したものを使うなどする。グリッパ座標相対で範囲を指定することで、グリッパ周りの点群を取り出すことが出来る。  

### グリッパ相対に点群を保存する
Anneさんが使ってらしゃったpythonのスクリプトを自分用に少し変えた[もの](https://github.com/Kanazawanaoaki/jsk_demos/blob/kanazawa-ow/jsk_2020_04_chahakobi/scripts/merge_pointcloud_from_tf.py)を使っている。  
中身は全てを理解しているわけではないが、PointCloudのROSトピックとTFを取得して点群部分をnumpyを使ってグリッパ相対に変換をしている。リアルタイム性が必要無い場合はこのようにnumpyで書くこともできるし、Open3Dのtransformも使えるかも。

### 点群をマージする
同じく、Anneさんが使ってらしゃったpythonのスクリプトを自分用に少し変えた[もの](https://github.com/Kanazawanaoaki/jsk_demos/blob/kanazawa-ow/jsk_2020_04_chahakobi/scripts/merge_pointcloud_from_tf.py)を使っている。  
おそらくだが、
```
self.points = self.points + points_transformed
```
でただ足し算をしているだけだと思われる。
マージの例としては、例えばOpen3Dでダウンサンプリングして結合する[サンプル](http://www.open3d.org/docs/release/tutorial/Advanced/multiway_registration.html#Make-a-combined-point-cloud)などがある。

## 机の上のものを認識する
机の上に乗っている物体を認識して掴むデモの認識部分を勉強する。  

最終的に呼ばれている認識部分のlaunchはこれ(https://github.com/jsk-ros-pkg/jsk_recognition/blob/master/jsk_pcl_ros/sample/tabletop_object_detector.launch )  

### jsk_pcl/OrganizedMultiPlaneSegmentation
https://jsk-recognition.readthedocs.io/en/latest/jsk_pcl_ros/nodes/organized_multi_plane_segmentation.html  
organizedな点群からconnected component analysis に基づいたpcl::OrganizedMultiPlaneSegmentationを使った平面検出を行い、複数の平面のセグメンテーションを行う。

### jsk_pcl_utils/PolygonMagnifier
https://jsk-docs.readthedocs.io/projects/jsk_recognition/en/latest/jsk_pcl_ros_utils/nodes/polygon_magnifier.html  
特定の範囲のポリゴンを拡大するらしい。なぜ使っているのかよくわからない。  

### jsk_pcl/MultiPlaneExtraction
https://jsk-docs.readthedocs.io/projects/jsk_recognition/en/latest/jsk_pcl_ros/nodes/multi_plane_extraction.html  
平面からの高さが指定した範囲内にある点群を抽出する。  

### jsk_pcl/EuclideanClustering
https://jsk-docs.readthedocs.io/projects/jsk_recognition/en/latest/jsk_pcl_ros/nodes/euclidean_clustering.html  
ユークリッド距離に基づいてクラスタリングを行い、セグメンテーションを行う。

### jsk_pcl/ClusterPointIndicesDecomposer
https://jsk-docs.readthedocs.io/projects/jsk_recognition/en/latest/jsk_pcl_ros/nodes/cluster_point_indices_decomposer.html  
クラスタリングされた結果を、配列にしてpubする。  
クラスターの中心をtfとして出して、バウンディングボックスも出す。  
バウンディングボックスの方向は最も近い平面に揃えられる。

## PointCloudをトラッキングする
机の上に乗っている物体を認識して掴むデモのトラッキング部分を理解する。  

最終的に呼ばれている認識部分のlaunchはこれ(https://github.com/jsk-ros-pkg/jsk_recognition/blob/master/jsk_pcl_ros/sample/tabletop_object_detector.launch )  
