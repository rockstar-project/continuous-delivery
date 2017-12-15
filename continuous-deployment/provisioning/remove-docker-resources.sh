#!/bin/bash

HOW_MANY=5

for (( instance=$HOW_MANY; $instance > 1; instance=$instance - 1 )); do
    eval $(docker-machine env kickster-node-${instance})
    docker stop $(docker ps -a -q)
    docker rm $(docker ps -a -q)
    docker rmi $(docker images -q)
done
