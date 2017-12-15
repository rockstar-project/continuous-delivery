#!/bin/sh

cd $APP_HOME
cd api-gateway; docker build -t $DOCKER_NAMESPACE/api-gateway .; cd ..
cd discovery-service; docker build -t $DOCKER_NAMESPACE/discovery-service .; cd ..
cd coreapi-content; docker build -t $DOCKER_NAMESPACE/coreapi-content .; cd ..
cd coreapi-model; docker build -t $DOCKER_NAMESPACE/coreapi-model .; cd ..
cd coreapi-template; docker build -t $DOCKER_NAMESPACE/coreapi-template .; cd ..
cd coreapi-artifact; docker build -t $DOCKER_NAMESPACE/coreapi-artifact .; cd ..
cd datastore-content; docker build -t $DOCKER_NAMESPACE/datastore-content .; cd ..
cd datastore-model; docker build -t $DOCKER_NAMESPACE/datastore-model .; cd ..
cd datastore-template; docker build -t $DOCKER_NAMESPACE/datastore-template .; cd ..

cd datastore-artifact && git add . && git commit -m "updated" && git push origin master && cd -
cd datastore-content && git add . && git commit -m "updated" && git push origin master && cd -
cd datastore-member && git add . && git commit -m "updated" && git push origin master && cd -
cd datastore-model && git add . && git commit -m "updated" && git push origin master && cd -
cd datastore-schema && git add . && git commit -m "updated" && git push origin master && cd -
cd datastore-template && git add . && git commit -m "updated" && git push origin master && cd -

cd coreapi-artifact && git add . && git commit -m "updated" && git push origin master && cd -
cd coreapi-content && git add . && git commit -m "updated" && git push origin master && cd -
cd coreapi-member && git add . && git commit -m "updated" && git push origin master && cd -
cd coreapi-model && git add . && git commit -m "updated" && git push origin master && cd -
cd coreapi-schema && git add . && git commit -m "updated" && git push origin master && cd -
cd coreapi-template && git add . && git commit -m "updated" && git push origin master && cd -
