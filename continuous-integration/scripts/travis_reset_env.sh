#!/bin/bash

travis env set DOCKER_USER $DOCKER_USER -p
travis env set DOCKER_PASSWORD $DOCKER_PASSWORD -p
travis env set DOCKER_NAMESPACE $DOCKER_NAMESPACE -P
