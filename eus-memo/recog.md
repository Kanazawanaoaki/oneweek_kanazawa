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
