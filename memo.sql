-- データベースを作成するSQL
CREATE DATABASE memos;

-- テーブルを作成するSQL
CREATE TABLE memo (id serial PRIMARY KEY, title text, description text);
