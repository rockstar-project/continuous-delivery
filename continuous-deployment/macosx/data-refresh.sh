#!/bin/bash

cd $APP_HOME/continuous-delivery/continuous-deployment/macosx
docker-compose stop metadatamongo && docker-compose rm -f metadatamongo
docker volume rm macosx_metadata-data
docker-compose rm -f metadataseed
docker rmi $DOCKER_NAMESPACE/datastore-metadata
cd $APP_HOME/datastore-metadata/
docker build -t $DOCKER_NAMESPACE/datastore-metadata .
cd -
docker-compose up -d metadatamongo
docker-compose up -d metadataseed

docker-compose exec productmysql /bin/bash
mysql -urockstar -prockstar123 --database rockstar_db_product
delete from PRODUCT; delete from ATTRIBUTE; delete from OPTION_ITEM; delete from MEDIA_ITEM;
cd ../../../datastore-product && ./script.sh && cd -
