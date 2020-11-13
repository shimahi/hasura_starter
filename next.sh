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

git clone git@github.com:shimahi/ariadne_starter.git
git clone git@github.com:shimahi/react_starter.git

cd react_starter && . ./next.sh client # client

cd ../

pwd
ls

cd ariadne_starter && . ./init.sh server # server

cd ../

pwd
ls

mv client ./packages/client
mv server ./packages/server # /

# # setting git
rm -rf .git
rm -f .gitignore README.md init.sh
touch .gitignore

## setting env
rm ./packages/client/.env.local
touch ./packages/client/.env.local
touch ./packages/hasura/.env
echo "NEXT_PUBLIC_HASURA_GRAPHQL_ENDPOINT=http://localhost:8080/v1/graphql
NEXT_PUBLIC_HASURA_GRAPHQL_ADMIN_SECRET=myadminsecretkey
NEXT_PUBLIC_AUTH_DOMAIN=
NEXT_PUBLIC_AUTH_CLIENT_ID=
NEXT_PUBLIC_AUTH_AUDIENCE=" >>./packages/client/.env.local
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

## setup hasura
sed -i -e "s/db_data/$1_db_data/" packages/hasura/docker-compose.yaml
find ./packages/hasura -name "docker-compose.yaml-e" | xargs rm

## download hasura and postgres container
cd packages/hasura && hasura init . # hasura

cd ../.. # /


## write README
touch README.md
echo "# $1" >>README.md

## move server package file
mv ./package.server.json packages/server/package.json

## reload client packages
rm -rf packages/client/node_modules &
wait
yarn install -W &
wait

rm -rf packages/client/.git packages/client/README.md packages/server/.git packages/server/README.md

## annotate python path to vscode
mkdir .vscode
touch .vscode/settings.json
echo '{
  "python.pythonPath": "./packages/server/.venv/bin/python3",
  "python.autoComplete.extraPaths": ["./packages/server/app"],
  "python.analysis.extraPaths": ["./packages/server/app"]
}
' >> .vscode/settings.json



# ## remove this script
find ./ -name "next.sh" | xargs rm
