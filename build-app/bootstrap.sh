#!/usr/bin/env bash
# install git and golang if not already installed
yum install git golang -y
# download nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
# reload PATH
source ~/.bash_profile
# install node lts
nvm install --lts=fermium
# install yarn package manager
npm install -g yarn
# install vue cli
yarn global add @vue/cli
# /app directory where app will be cloned
rm -rf /app
mkdir /app
cd /app
# clone repo into current dir
git clone https://github.com/jdmendozaa/vuego-demoapp.git .
# build go server
cd /app/server
mkdir -p /shared/server
go build -o /shared/server

cd /app/spa
# generate yarn.lock from package-lock.json
yarn import
# remove package-lock.json
rm -f package-lock.json
# install vue app dependencies
yarn install
# update dependencies
yarn upgrade
# get the VUE_APP_API_ENDPOINT from environment and write it to .env file
echo "VUE_APP_API_ENDPOINT=$VUE_APP_API_ENDPOINT" > .env.production
# build production app and move to shared directory
yarn build
# compress and move to shared directory
tar -zcvf vue_dist.tar.gz ./dist
rm -rf /shared/spa
mkdir -p /shared/spa
mv vue_dist.tar.gz /shared/spa