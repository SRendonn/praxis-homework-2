#!/usr/bin/env bash
# install git if not already installed
yum install git -y

# install Golang
wget -nc -O go.tar.gz https://golang.org/dl/go1.17.2.linux-amd64.tar.gz
# extract tar ball
tar -C /usr/local -xzf go.tar.gz
# add folder to path
export PATH=$PATH:/usr/local/go/bin

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
rm -rf ~/app
mkdir ~/app
cd ~/app
# clone repo into current dir
git clone https://github.com/jdmendozaa/vuego-demoapp.git .
# build go server
cd ~/app/server
mkdir -p /shared/server
# in theory it should get the PORT and IPSTACK_API_KEY variables from the environment
go build -o /shared/server

cd ~/app/spa
# generate yarn.lock from package-lock.json
yarn import
# remove package-lock.json
rm -f package-lock.json
# update dependencies
yarn upgrade
# install vue app dependencies
yarn install
# get the VUE_APP_API_ENDPOINT from environment and write it to .env file
echo $VUE_APP_API_ENDPOINT > .env
# build production app and move to shared directory
yarn build
rm -rf /shared/dist
mv dist /shared/