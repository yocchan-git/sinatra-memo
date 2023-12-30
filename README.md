## 環境構築の手順
### ローカル環境にcloneする
以下のコマンドを実行してください。
（フォークした場合はURLを変更してください）
```bash
git clone git@github.com:yocchan-git/sinatra-memo.git
```

### データベースを作成しよう
PostgreSQLにデータベースとテーブルを作成してください。
```bash
psql -U (ユーザー名)
CREATE DATABASE memos;
\c memos
CREATE TABLE memo (id serial PRIMARY KEY, title text, description text);
\q
```

### 移動して初期設定をする
以下のコマンドを実行して、初期設定とサーバーを起動してください
```bash
cd sinatra-memo
bundle install
ruby routes.rb -p 4567
```

### URLにアクセス
お疲れ様です！あとはアクセスするだけですね。
http://localhost:4567/memos

ぜひ触ってくださいね！
