#!/bin/bash

docker-compose run -d contentmysql
docker exec -i -t contentmysql /bin/bash
mysql --user=kickster --password=kickster123 --database=kickster_db_content < content/schema.sql
mysql --user=kickster --password=kickster123 --database=kickster_db_content < content/seed.sql