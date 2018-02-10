# MAC OS Deployment

## redeploy discovery-service

```
docker-compose stop discovery && docker-compose rm -f discovery
docker rmi $DOCKER_NAMESPACE/discovery-service
cd $APP_HOME/discovery-service/
mvn clean package
docker build -t $DOCKER_NAMESPACE/discovery-service .
cd -
docker-compose up -d discovery
docker-compose logs --follow discovery
```

## redeploy api-gateway

```
docker-compose stop gateway && docker-compose rm -f gateway
docker rmi $DOCKER_NAMESPACE/api-gateway
cd $APP_HOME/api-gateway/
mvn clean package
docker build -t $DOCKER_NAMESPACE/api-gateway .
cd -
docker-compose up -d gateway
docker-compose logs --follow gateway
```

## redeploy coreapi-product

```
docker-compose stop productapi && docker-compose rm -f productapi
docker rmi $DOCKER_NAMESPACE/coreapi-product
cd $APP_HOME/coreapi-product/
mvn clean package
docker build -t $DOCKER_NAMESPACE/coreapi-product .
cd -
docker-compose up -d productapi
docker-compose logs --follow productapi
```

## redeploy datastore-product

```
docker-compose stop productmysql && docker-compose rm -f productmysql
docker rmi $DOCKER_NAMESPACE/datastore-product
cd $APP_HOME/datastore-product/
docker build -t $DOCKER_NAMESPACE/datastore-product .
cd -
docker-compose up -d productmysql
docker-compose logs --follow productmysql
```

## redeploy coreapi-metadata

```
docker-compose stop metadataapi && docker-compose rm -f metadataapi
docker rmi $DOCKER_NAMESPACE/coreapi-metadata
cd $APP_HOME/coreapi-metadata/
mvn clean package
docker build -t $DOCKER_NAMESPACE/coreapi-metadata .
cd -
docker-compose up -d metadataapi
docker-compose logs --follow metadataapi
```

## redeploy datastore-metadata

```
docker-compose stop metadatamongo && docker-compose rm -f metadatamongo
docker rmi $DOCKER_NAMESPACE/datastore-metadata
cd $APP_HOME/datastore-metadata/
docker build -t $DOCKER_NAMESPACE/datastore-metadata .
cd -
docker-compose up -d metadatamongo
docker-compose exec metadatamongo /bin/bash

docker-compose stop metadataseed && docker-compose rm -f metadataseed
docker-compose up -d metadataseed
docker-compose logs --follow metadataseed
```

## redeploy coreapi-collection

```
docker-compose stop collectionapi && docker-compose rm -f collectionapi
docker rmi $DOCKER_NAMESPACE/coreapi-collection
cd $APP_HOME/coreapi-collection/
mvn clean package
docker build -t $DOCKER_NAMESPACE/coreapi-collection .
cd -
docker-compose up -d collectionapi
docker-compose logs --follow collectionapi
```

## redeploy datastore-collection

```
docker-compose stop collectionmysql && docker-compose rm -f collectionmysql
docker rmi $DOCKER_NAMESPACE/datastore-collection
cd $APP_HOME/datastore-collection/
docker build -t $DOCKER_NAMESPACE/datastore-collection .
cd -
docker-compose up -d collectionmysql
docker-compose logs --follow collectionmysql
```

## redeploy coreapi-artifact

```
docker-compose stop artifactapi && docker-compose rm -f artifactapi
docker rmi $DOCKER_NAMESPACE/coreapi-artifact
cd $APP_HOME/coreapi-artifact/
mvn clean package -Dmaven.test.skip=true
docker build -t $DOCKER_NAMESPACE/coreapi-artifact .
cd -
docker-compose up -d artifactapi
docker-compose logs --follow artifactapi
```
