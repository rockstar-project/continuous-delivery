#!/bin/sh

cd $APP_HOME
cd api-gateway && mvn clean package && cd ..
cd discovery-service && mvn clean package && cd ..
cd coreapi-metadata && mvn clean package && cd ..
cd coreapi-product && mvn clean package && cd ..
cd coreapi-collection && mvn clean package && cd ..
cd coreapi-artifact && mvn clean package && cd ..
