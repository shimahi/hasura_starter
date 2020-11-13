# SAHARA

- クライアント → React
- 第一GraphQLエンドポイント(データソース管理) → Hasura
- 第二GraphQL/RESTエンドポイント(バッチ処理) → Ariadne + FastAPI
- DB → PostgreSQL
のフルスタック構成でアプリ開発を行うためのwebpack/dockerキット

##### 動作環境  
Node.js `^14.3`  

Yarn `^1.22.4`

Docker `20.10.0-beta1`

Python `3.8.5`

Poetry `1.1.0`

Hasura CLI `v1.3.2`

##### 使用方法  
引数にアプリ名をつけて `source` または `.` コマンドを実行してください。


```
# Reactの場合
$ . ./init.sh your_app_name

# Next.jsの場合
$ . ./next.sh your_app_name
```

```
# クライアントの起動
yarn client dev  # → http://localhost:3000

# hasura+postgresコンテナの起動
yarn hasura start

# hasuraコンソールの起動
yarn hasura console  # → http://localhost:9695

# Pythonサーバーの起動
yarn server start  # → http://localhost:4000

```

### TODO: 

リモートのHasuraへのメタデータの適用やCloud RunへのPythonサーバのデプロイをGithub Actionsで自動化する
