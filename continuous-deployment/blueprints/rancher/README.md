## Model API Microservice

#### Run MySQL database

```
$ docker-compose up -d modelmysql
```

#### Install Model Schema

```
$ docker-compose exec modelmysql mysql --user=kickster --password=kickster123 --database=kickster_db_model < model/schema.sql
$ docker-compose exec modelmysql mysql --user=kickster --password=kickster123 --database=kickster_db_model < model/seed.sql
```

#### Run Model API microservice

```
$ docker-compose up -d modelapi
```

#### Connect to the API endpoint

```
$ curl http://localhost/v1/models | jq .
```

#### Redeploy `modelapi` with code changes

```
docker-compose stop modelapi
docker-compose rm -f modelapi
mvn clean package -f $APP_HOME/coreapi-model -Dmaven.test.skip=true
docker rmi $DOCKER_REGISTRY/kickster/coreapi-model
cd $APP_HOME/coreapi-model && docker build -t $DOCKER_REGISTRY/kickster/coreapi-model .
cd - && docker-compose up -d modelapi
docker-compose logs --follow modelapi
```
