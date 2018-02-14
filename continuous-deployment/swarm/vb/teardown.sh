#!/bin/bash

STACK_NAME=$1

docker stack rm ${STACK_NAME}

docker-machine stop ${STACK_NAME}-swarm-manager
docker-machine rm -f ${STACK_NAME}-swarm-manager

docker-machine stop ${STACK_NAME}-swarm-worker1
docker-machine rm -f ${STACK_NAME}-swarm-worker1

docker-machine stop ${STACK_NAME}-swarm-worker2
docker-machine rm -f ${STACK_NAME}-swarm-worker2

docker-machine stop ${STACK_NAME}-swarm-worker3
docker-machine rm -f ${STACK_NAME}-swarm-worker3
