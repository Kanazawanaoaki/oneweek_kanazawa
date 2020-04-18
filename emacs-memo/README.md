# emacs memo
emacsの使い方など。  

## how to edit
emacsを立ち上げる。
```
emacs -nw [ファイル名]
```

- カーソル移動  
C-f : カーソルを一文字右に移動  
C-b : カーソルを一文字左に移動  
C-p : カーソルを一行上に移動  
C-n : カーソルを一行下に移動  
C-a : カーソルを行頭に移動  
C-e : カーソルを行末に移動  

- 画面の分割  
C-x 2 : 画面を上下二分割にする  
C-x 3 : 画面を左右二分割にする  
C-x o : 画面分割を移動する  
C-x 1 : 画面の分割を元に戻す  

- ファイルの読み書き  
C-x C-s : ファイルに現在の内容をセーブ  
C-x C-f : ファイルをオープン  
C-x C-w : ファイルの名前を変更して保存  

- Emacsの終了  
C-x C-c : Emacsを終了  

- 削除  
C-d : カーソルのある位置にある文字を削除  

- 検索  
C-s : カーソルのある位置以降をインクリメンタル検索  

- カット&ペースト  
C-k : カーソルのある位置以降の文字を切り取る  
C-y : C-kで切り取った部分をカーソル位置に貼り付ける   

### その他独自調べ  
- [取り消し](https://cns-guide.sfc.keio.ac.jp/2004/6/2/5.html)  
取り消し : C-x u  

- [リージョンの指定など](http://www.rsch.tuis.ac.jp/~ohmi/literacy/emacs/emacs-copypaste.html)  
領域指定 : C-spc  
カット : C-w  
コピー : M-w  
ペースト : C-y  

- [検索](https://cns-guide.sfc.keio.ac.jp/2004/6/1/11.html)  
検索開始 : C-s C-r  
次へ : C-s  
前へ : C-r  

- [文字列置換](https://vinelinux.org/docs/vine6/emacs-guide/emacs-search.html)  
M-%  
置換前の文字列を入力してEnter  
置換後の文字列を入力してEnter  
yを押していって変えていく。  

## use shell  
- 方法１:ターミナルに戻る。  
プロセスをバックグラウンドに : C-z  
フォアグラウンドに戻す : fg  

- 方法２:emacsでshell  
shellを開く : M-x shell  
戻る : M-x quit  
前のコマンド : Alt-p  

## links
[Emacs Beginner's HOWTO](http://archive.linux.or.jp/JF/JFdocs/Emacs-Beginner-HOWTO.html)  
とくに[2.3 キーボードの基本](http://archive.linux.or.jp/JF/JFdocs/Emacs-Beginner-HOWTO-2.html#ss2.3)が参考になる。  

[GNU Emacs マニュアル](http://flex.phys.tohoku.ac.jp/texi/emacs-jp/emacs-jp_toc.html)  
とくに[マークとリージョン](http://flex.phys.tohoku.ac.jp/texi/emacs-jp/emacs-jp_27.html#SEC42)が使えると良い。  
