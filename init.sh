#!/bin/sh

if [ $# != 1 ]; then
  echo "Please set an argument"
  return 2>&- || exit
fi

#rename this directory
initialDir=basename$(pwd)
initialDirVal=$(basename ${initialDir})
mv ../${initialDirVal} ../"$1" &
wait
cd ../"$1"

## setting git
rm -rf .git
rm -f .gitignore README.md
touch .gitignore


## setting env
touch ./packages/client/.env
touch ./packages/hasura/.env
echo "HASURA_GRAPHQL_ENDPOINT=http://localhost:8080/v1/graphql
HASURA_GRAPHQL_ADMIN_SECRET=myadminsecretkey
AUTH_DOMAIN=
AUTH_CLIENT_ID=
AUTH_AUDIENCE=" >>./packages/client/.env
echo "HASURA_GRAPHQL_DATABASE_URL=postgres://postgres:postgrespassword@postgres:5432/postgres
POSTGRES_PASSWORD=postgrespassword
HASURA_GRAPHQL_ADMIN_SECRET=myadminsecretkey
HASURA_GRAPHQL_JWT_SECRET=" >>./packages/hasura/.env

echo '# dependencies
/node_modules
/.pnp
.pnp.js

# testing
/coverage

# production
/dist

# misc
.DS_Store
!.env.example
.env*

npm-debug.log*
yarn-debug.log*
yarn-error.log*

' >>.gitignore
git init

# assign postgres volume path on Docker
sed -i -e "s/db_data/$1_db_data/" packages/hasura/docker-compose.yaml
find ./packages/hasura -name "docker-compose.yaml-e" | xargs rm

## download hasura and postgres container
cd packages/hasura && hasura init .
cd ../api/ && poetry install && docker-compose build

cd ../../

## write README
touch README.md
echo "# $1" >>README.md

### import npm packages
yarn workspace client add react react-dom @emotion/core ress @apollo/client graphql
yarn workspace client add -D typescript @types/{node,react,react-dom} \
  webpack webpack-{cli,dev-server,merge} {ts,style,css,url,file,babel}-loader html-webpack-plugin worker-plugin dotenv-webpack \
  @emotion/babel-preset-css-prop \
  @babel/{core,preset-env,preset-react} \
  @graphql-codegen/{cli,typescript,typescript-operations,typescript-react-apollo} \
  prettier eslint eslint-config-{airbnb-typescript,prettier} eslint-plugin-{import,jsx-a11y,prettier,react,react-hooks} \
  @typescript-eslint/eslint-plugin @typescript-eslint/parser \
  lint-staged husky &

wait
rm -rf node_modules &
wait
yarn install -W

## remove this script
find ./ -name "init.sh" | xargs rm
