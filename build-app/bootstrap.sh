#!/usr/bin/env bash
# install git if not already installed
sudo yum install git -y

# install Golang
wget -nc -O go.tar.gz https://golang.org/dl/go1.17.2.linux-amd64.tar.gz
# extract tar ball
sudo tar -C /usr/local -xzf go.tar.gz
# add folder to path
export PATH=$PATH:/usr/local/go/bin

# download nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
# reload PATH
source ~/.bash_profile
# install node lts
nvm install --lts=fermium
# install vue cli
npm install -g yarn

yarn global add @vue/cli

mkdir -p ~/app
cd ~/app
# clone repo into current dir
git clone https://github.com/jdmendozaa/vuego-demoapp.git .
# build go app
cd ~/app/server
sudo mkdir -p /shared/server
sudo go build -o /shared/server
# install vue app dependencies
cd ~/app/spa
# install vue cli globally and add eslint plugin to fix vue-cli-service bug
yarn install
# build production app and move to shared directory
yarn build
sudo mv dist /shared/