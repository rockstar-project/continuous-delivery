#!/bin/sh

# redeploy coreapi-template

docker-compose stop templateapi && docker-compose rm -f templateapi
docker rmi $DOCKER_NAMESPACE/coreapi-template
cd $APP_HOME/coreapi-template/
mvn clean package
docker build -t $DOCKER_NAMESPACE/coreapi-template .
cd -
docker-compose up -d templateapi
docker-compose logs --follow templateapi

# redeploy datastore-template

docker-compose stop templatemysql && docker-compose rm -f templatemysql
docker rmi $DOCKER_NAMESPACE/datastore-template
cd $APP_HOME/datastore-template/
docker build -t $DOCKER_NAMESPACE/datastore-template .
cd -
docker-compose up -d templatemysql
docker-compose logs --follow templatemysql

# redeploy discovery-service
docker-compose stop discovery && docker-compose rm -f discovery
docker rmi $DOCKER_NAMESPACE/discovery-service
cd $APP_HOME/discovery-service/
mvn clean package
docker build -t $DOCKER_NAMESPACE/discovery-service .
cd -
docker-compose up -d discovery
docker-compose logs --follow discovery

# redeploy api-gateway
docker-compose stop gateway && docker-compose rm -f gateway
docker rmi $DOCKER_NAMESPACE/api-gateway
cd $APP_HOME/api-gateway/
mvn clean package
docker build -t $DOCKER_NAMESPACE/api-gateway .
cd -
docker-compose up -d gateway
docker-compose logs --follow gateway


# redeploy datastore-content

docker-compose stop contentmysql && docker-compose rm -f contentmysql
docker rmi $DOCKER_NAMESPACE/datastore-content
cd $APP_HOME/datastore-content/
docker build -t $DOCKER_NAMESPACE/datastore-content .
cd -
docker-compose up -d contentmysql
docker-compose exec contentmysql /bin/bash

# redeploy coreapi-content

docker-compose stop contentapi && docker-compose rm -f contentapi
docker rmi $DOCKER_NAMESPACE/coreapi-content
cd $APP_HOME/coreapi-content/
mvn clean package
docker build -t $DOCKER_NAMESPACE/coreapi-content .
cd -
docker-compose up -d contentapi
docker-compose logs --follow contentapi

# redeploy datastore-member

docker-compose stop membermysql && docker-compose rm -f membermysql
docker rmi $DOCKER_NAMESPACE/datastore-member
cd $APP_HOME/datastore-member/
docker build -t $DOCKER_NAMESPACE/datastore-member .
cd -
docker-compose up -d membermysql

# redeploy coreapi-member

docker-compose stop memberapi && docker-compose rm -f memberapi
docker rmi $DOCKER_NAMESPACE/coreapi-member
cd $APP_HOME/coreapi-member/
mvn clean package
docker build -t $DOCKER_NAMESPACE/coreapi-member .
cd -
docker-compose up -d memberapi
docker-compose logs --follow memberapi

# redeploy datastore-artifact

docker-compose stop artifactmysql && docker-compose rm -f artifactmysql
docker rmi $DOCKER_NAMESPACE/datastore-artifact
cd $APP_HOME/datastore-artifact/
docker build -t $DOCKER_NAMESPACE/datastore-artifact .
cd -
docker-compose up -d artifactmysql

# redeploy coreapi-artifact

docker-compose stop artifactapi && docker-compose rm -f artifactapi
docker rmi $DOCKER_NAMESPACE/coreapi-artifact
cd $APP_HOME/coreapi-artifact/
mvn clean package
docker build -t $DOCKER_NAMESPACE/coreapi-artifact .
cd -
docker-compose up -d artifactapi
docker-compose logs --follow artifactapi

# redeploy datastore-model

docker-compose stop model && docker-compose rm -f modelmysql
docker rmi $DOCKER_NAMESPACE/datastore-model
cd $APP_HOME/datastore-model/
docker build -t $DOCKER_NAMESPACE/datastore-model .
cd -
docker-compose up -d modelmysql

docker-compose stop modelapi && docker-compose rm -f modelapi
docker rmi $DOCKER_NAMESPACE/coreapi-model
cd $APP_HOME/coreapi-model/
mvn clean package
docker build -t $DOCKER_NAMESPACE/coreapi-model .
cd -
docker-compose up -d modelapi
docker-compose logs --follow modelapi

# redeploy datastore-schema

docker-compose stop schemamongo && docker-compose rm -f schemamongo
docker rmi $DOCKER_NAMESPACE/datastore-schema
cd $APP_HOME/datastore-schema/
docker build -t $DOCKER_NAMESPACE/datastore-schema .
cd -
docker-compose up -d schemamongo
docker-compose exec schemamongo /bin/bash

mongoimport --host schemamongo --db kickster_db_schema --collection schemas --type json --file /schemas.json --jsonArray

# redeploy coreapi-schema

docker-compose stop schemaapi && docker-compose rm -f schemaapi
docker rmi $DOCKER_NAMESPACE/coreapi-schema
cd $APP_HOME/coreapi-schema/
mvn clean package
docker build -t $DOCKER_NAMESPACE/coreapi-schema .
cd -
docker-compose up -d schemaapi
docker-compose logs --follow schemaapi

docker-compose stop bootifulcodegen && docker-compose rm -f bootifulcodegen
docker rmi $DOCKER_NAMESPACE/codegen-bootiful
cd $APP_HOME/codegen-bootiful/
mvn clean package
docker build -t $DOCKER_NAMESPACE/codegen-bootiful .
cd -
docker-compose up -d bootifulcodegen
docker-compose logs --follow bootifulcodegen

docker-compose stop gonutscodegen && docker-compose rm -f gonutscodegen
docker rmi $DOCKER_NAMESPACE/codegen-gonuts
cd $APP_HOME/codegen-gonuts/
mvn clean package
docker build -t $DOCKER_NAMESPACE/codegen-gonuts .
cd -
docker-compose up -d gonutscodegen
docker-compose logs --follow gonutscodegen

docker-compose stop pythonflaskcodegen && docker-compose rm -f pythonflaskcodegen
docker rmi $DOCKER_NAMESPACE/codegen-pythonflask
cd $APP_HOME/codegen-pythonflask/
mvn clean package
docker build -t $DOCKER_NAMESPACE/codegen-pythonflask .
cd -
docker-compose up -d pythonflaskcodegen
docker-compose logs --follow pythonflaskcodegen

docker-compose stop nodeexpressjscodegen && docker-compose rm -f nodeexpressjscodegen
docker rmi $DOCKER_NAMESPACE/codegen-nodeexpressjs
cd $APP_HOME/codegen-nodeexpressjs/
mvn clean package
docker build -t $DOCKER_NAMESPACE/codegen-nodeexpressjs .
cd -
docker-compose up -d nodeexpressjscodegen
docker-compose logs --follow nodeexpressjscodegen
