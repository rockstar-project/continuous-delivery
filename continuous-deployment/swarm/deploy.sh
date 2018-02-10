#!/bin/bash

STACK_NAME=$1
eval $(docker-machine env ${STACK_NAME}-swarm-manager)

docker login --username $DOCKER_USER --password $DOCKER_PASSWORD

docker stack deploy --compose-file docker-compose.yml --with-registry-auth ${STACK_NAME}
