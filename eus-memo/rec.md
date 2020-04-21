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
```
roslaunch jsk_2019_10_semi hsi_color_filter.launch
```

[HSIColorFilter](https://jsk-docs.readthedocs.io/projects/jsk_recognition/en/latest/jsk_pcl_ros/nodes/hsi_color_filter.html)を使って指定した範囲のHSI値のpoint cloudのみを抽出する。  

HSIの値は、
```
rosrun rqt_reconfigure rqt_reconfigur
```
でGUIでいじることが出来る。RvizでPointCloud2やBoundingBoxArrayを見ることでフィルタの結果をみながら調整する。  

HSIフィルタを通した点群について、[EuclideanClustering](https://jsk-docs.readthedocs.io/projects/jsk_recognition/en/latest/jsk_pcl_ros/nodes/euclidean_clustering.html)をすることで、ユークリッド距離を使ってクラスタリングする。  

その結果に対して、[ClusterPointIndicesDecomposer](https://jsk-docs.readthedocs.io/projects/jsk_recognition/en/latest/jsk_pcl_ros/nodes/cluster_point_indices_decomposer.html)をすることでbounding boxを出している。  
クラスタリングした結果を用いて、それぞれのクラスターのpoint cloudとか重心位置とかを出すようになっている。  

## 画像からのパターンマッチング
