#!/bin/bash

# Show swarm cluster
eval $(docker-machine env rockstarproject-master)
echo "===== Swarm Cluster"
docker node ls

# Remove master nodes
docker-machine stop rockstarproject-master
docker-machine rm -f rockstarproject-master

# Remove all worker nodes
for i in $(seq "${SWARM_NUM_WORKER}"); do
  docker-machine stop rockstarproject-worker-${i}
  docker-machine rm -f rockstarproject-worker-${i}
done
