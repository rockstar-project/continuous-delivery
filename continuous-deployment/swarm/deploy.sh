#!/bin/bash

set -e

if [[ -z "${ENVIRONMENT}" ]]; then
  echo missing ENVIRONMENT environment variable
  exit 1
fi
if [[ -z "${STACK_NAME}" ]]; then
  echo missing STACK_NAME environment variable
  exit 1
fi
if [[ -z "${DOCKER_USER}" ]]; then
  echo missing DOCKER_USER environment variable
  exit 1
fi
if [[ -z "${DOCKER_PASSWORD}" ]]; then
  echo missing DOCKER_USER environment variable
  exit 1
fi

eval $(docker-machine env aws-${STACK_NAME}-swarm-manager)

docker login --username $DOCKER_USER --password $DOCKER_PASSWORD

docker stack deploy --compose-file docker-compose.yml --with-registry-auth ${STACK_NAME}

exit 0
