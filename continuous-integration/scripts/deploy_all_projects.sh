#!/bin/sh

cd $APP_HOME

cd discovery-service; docker-compose up -d discovery; cd ..
cd api-gateway; docker-compose up -d gateway; cd ..

docker-compose up -d contentmysql
docker-compose exec contentmysql /bin/bash
mysql --user=kickster --password=kickster123 --database=kickster_db_content < /content/schema.sql
mysql --user=kickster --password=kickster123 --database=kickster_db_content < /content/seed.sql
docker-compose up -d contentapi

docker-compose up -d membermysql
docker-compose exec membermysql /bin/bash
mysql --user=kickster --password=kickster123 --database=kickster_db_member < /member/schema.sql
mysql --user=kickster --password=kickster123 --database=kickster_db_member < /member/seed.sql
docker-compose up -d membermysql

docker-compose up -d modelmysql
docker-compose exec modelmysql /bin/bash
mysql --user=kickster --password=kickster123 --database=kickster_db_model < model/schema.sql
mysql --user=kickster --password=kickster123 --database=kickster_db_model < model/seed.sql
docker-compose up -d modelapi

docker-compose up -d templatemysql
docker-compose exec templatemysql /bin/bash
mysql --user=kickster --password=kickster123 --database=kickster_db_template < template/schema.sql
mysql --user=kickster --password=kickster123 --database=kickster_db_template < template/seed.sql
docker-compose up -d templateapi

docker-compose up -d artifactapi
