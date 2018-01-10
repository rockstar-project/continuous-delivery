#!/bin/sh

git config --global user.name "email@example.com"
git config --global user.email "email@example.com"

cd $APP_HOME
git clone https://github.com/rockstar-project/api-gateway.git
git clone https://github.com/rockstar-project/discovery-service.git
git clone https://github.com/rockstar-project/coreapi-metadata.git
git clone https://github.com/rockstar-project/coreapi-product.git
git clone https://github.com/rockstar-project/coreapi-artifact.git
git clone https://github.com/rockstar-project/datastore-metadata.git
git clone https://github.com/rockstar-project/datastore-product.git
