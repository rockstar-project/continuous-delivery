#!/bin/bash

MASTER_NODE=rockstarproject-master

eval $(docker-machine env rockstarproject-master)
docker stack deploy --compose-file ../../blueprints/dockercloud/docker-compose.yml rockstar-api
