# Housework memo
家事支援の研究についてのメモ.

## JSK
JSKでの家事支援の研究.IRT関連などがある.

### 日常生活支援ヒューマノイドの環境認識・行動制御
Environment Recognition and Behavior Control of Humanoid for Daily Tasks.  
2008年  
http://www.jsk.t.u-tokyo.ac.jp/~k-okada/paper/2008_jrsj_okada_hrp2.pdf  
記憶ベースの認識と動作計画を使った家事支援実現についての論文.  
動作計画には,基準位置座標(spot),物体を把持する際の位置と姿勢の拘束条件(handle),物体を操作する際の基準座標並びに視覚検証の注視点である(attention).  
認識には,三次元表面形状(shape),色情報(color),三次元エッジ情報(edges).  
これらの記憶を利用する.  
タスク行動実験として,お茶注ぎやコップ片付けなどが挙げられている.  

### IRTホームアシスタントロボットによる掃除片付け作業シーケンスのPR2による実現
2013年  
https://jglobal.jst.go.jp/detail?JGLOBAL_ID=201302251087214890  
IRT研究プロジェクトにおいて開発したAR(Assistant Robot)ロボットで行われた実験をROSとPR2を使って行った研究.  
タスクとしては,トレイ運搬,洗濯物片付け,床面掃引.
IRTにおいてARを使った時とPR2を使った今回の比較をしている.  
