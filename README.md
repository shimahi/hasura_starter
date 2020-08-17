# Hasura Starter
React(webpack) + Hasura(docker) + PostgreSQL(docker) の環境構築を行うシェルスクリプトです。

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

# クライアントの起動
yarn client dev
```



# TODO 
- ApolloClientのProviderを作っておく
