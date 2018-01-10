#!/bin/sh

cd $APP_HOME
cd api-gateway; docker build -t $DOCKER_NAMESPACE/api-gateway .; cd ..
cd discovery-service; docker build -t $DOCKER_NAMESPACE/discovery-service .; cd ..
cd coreapi-metadata; docker build -t $DOCKER_NAMESPACE/coreapi-metadata .; cd ..
cd coreapi-product; docker build -t $DOCKER_NAMESPACE/coreapi-product .; cd ..
cd coreapi-artifact; docker build -t $DOCKER_NAMESPACE/coreapi-artifact .; cd ..
cd datastore-metadata; docker build -t $DOCKER_NAMESPACE/datastore-metadata .; cd ..
cd datastore-product; docker build -t $DOCKER_NAMESPACE/datastore-product .; cd ..

cd datastore-metadata && git add . && git commit -m "updated" && git push origin master && cd -
cd datastore-product && git add . && git commit -m "updated" && git push origin master && cd -
cd coreapi-artifact && git add . && git commit -m "updated" && git push origin master && cd -
cd coreapi-metadata && git add . && git commit -m "updated" && git push origin master && cd -
cd coreapi-product && git add . && git commit -m "updated" && git push origin master && cd -
