#!/bin/bash

HOW_MANY=5

for (( instance=$HOW_MANY; $instance > 1; instance=$instance - 1 )); do
    docker-machine stop kickster-node-${instance}
    docker-machine rm -y kickster-node-${instance}
done
