#!/bin/sh

cd $APP_HOME
cd api-gateway; mvn clean package; cd ..
cd discovery-service; mvn clean package; cd ..
cd coreapi-content; mvn clean package; cd ..
cd coreapi-model; mvn clean package; cd ..
cd coreapi-template; mvn clean package; cd ..
cd coreapi-artifact; mvn clean package; cd ..
