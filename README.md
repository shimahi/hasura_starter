# SAHARA

フロントエンド(React) + 第一エンドポイント(Hasura) + DB(PostgreSQL) + 第二エンドポイント(FastAPI)  
のフルスタックアプリ開発を行うためのwebpack/dockerキット

動作環境  
Node.js `^14.3`  
Yarn `^1.22.4`

使用方法  
引数にアプリ名をつけて source または . コマンドを実行してください。


```
$ . ./init.sh your_app_name
```

```
# hasura+postgresコンテナの起動
yarn hasura start

# hasuraコンソールの起動
yarn hasura console

# FastAPIの起動
yarn server start

# クライアントの起動
yarn client dev
```

#TODO: 
Hasura Cloudへのメタデータの適用・Cloud RunへのFastAPIのデプロイをGithub Actionsで自動化する
