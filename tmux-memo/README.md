# tmux
tmuxの使い方メモ

とりあえず　https://qiita.com/nmrmsys/items/03f97f5eabec18a3a18b

## コマンドライン操作
```
# 新規セッション開始
tmux

# 名前をつけて新規セッション開始
tmux new -s <セッション名>

# セッションの一覧表示
tmux ls

# 接続クライアントの一覧表示
tmux lsc

# セッションを再開 ※-t <対象セッション名>でセッション名の指定も可能
tmux a

# tmux a -t 0 

# セッションを終了 ※-t <対象セッション名>でセッション名の指定も可能
tmux kill-session

# tmux全体を終了
tmux kill-server

# その他コマンドを実行
tmux [command [flags]]
```

## キー操作
https://qiita.com/zwirky/items/adbf22abad7d7822456b

`Ctl+b c` 新規
