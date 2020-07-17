# cooking memo
調理関係の先行研究についてのサーベイのメモ.  

## Michael Beetz先生
日本語の記事: https://roboteer-tokyo.com/archives/383  

web上でレシピから自然言語処理をしてなど.  
パンケーキ作りの動作も作っている.  
最近はシミュレーションとの組み合わせ?  

youtubeなどにデモの動画もある.(関連研究のyoutube list:
https://www.youtube.com/playlist?list=PLeld9w8DXfBJirNhzfGAuLCuX98qjTdgC
)  

Open EASEプロジェクトとか  
Robohowとかのプロジェクト  

### Robotic Roommates Making Pancakes
パンケーキを作る2011年のデモ,およびそのデモについての論文.  
論文: https://ieeexplore.ieee.org/document/6100855  
```
@INPROCEEDINGS{6100855,
  author={M. {Beetz} and U. {Klank} and I. {Kresse} and A. {Maldonado} and L. {Mösenlechner} and D. {Pangercic} and T. {Rühr} and M. {Tenorth}},
  booktitle={2011 11th IEEE-RAS International Conference on Humanoid Robots},
  title={Robotic roommates making pancakes},
  year={2011},
  volume={},
  number={},
  pages={529-536},
}
```

## 調理動作マニピュレーション
調理の中の一つの動作に注目したマニピュレーション研究.

### DeepMPC
http://deepmpc.cs.cornell.edu/  
NNの学習を使ってMPCを行い包丁操作を行う.  
包丁の研究は流行ったらしい?  
論文: https://www.semanticscholar.org/paper/DeepMPC%3A-Learning-Deep-Latent-Features-for-Model-Lenz-Knepper/e89d656a39fc3b08af47ebb9a583e182a596dabe  
```
@inproceedings{Lenz2015DeepMPCLD,  
  title={DeepMPC: Learning Deep Latent Features for Model Predictive Control},  
  author={Ian Lenz and Ross A. Knepper and Ashutosh Saxena},  
  booktitle={Robotics: Science and Systems},  
  year={2015}  
}
```

### Direct Collocation for Dynamic Behaviors with Nonprehensile Contacts:Application to Flipping Burgers
ハンバーグ,miso roboticsというベンチャーが出したらしい.  
運動方程式を満たしてタスク達成を満たすような拘束条件を設けった連続最適化で関節角度をプランニングする.  
論文： https://ieeexplore.ieee.org/document/8410040  
```
@ARTICLE{8410040,
    author={S. {Kolathaya} and W. {Guffey} and R. W. {Sinnet} and A. D. {Ames}},
    journal={IEEE Robotics and Automation Letters},
    title={Direct Collocation for Dynamic Behaviors With Nonprehensile Contacts: Application to Flipping Burgers},
    year={2018},
    volume={3},  
    number={4},  
    pages={3677-3684},
}
```

## パーソナライズ
個人の好みに合わせた調理を行う方法の研究.

### Improving Robotic Cooking Using Batch Bayesian Optimization
オムレツ,ベイズ最適化によってパーソナライズした作り方にしている?  
ロボット自体はかなり産業用ロボット感がある.  
論文： https://ieeexplore.ieee.org/document/8954776  
```
@ARTICLE{8954776,
  author={K. {Junge} and J. {Hughes} and T. G. {Thuruthel} and F. {Iida}},
  journal={IEEE Robotics and Automation Letters},
  title={Improving Robotic Cooking Using Batch Bayesian Optimization},
  year={2020},
  volume={5},
  number={2},
  pages={760-765},
}
```
