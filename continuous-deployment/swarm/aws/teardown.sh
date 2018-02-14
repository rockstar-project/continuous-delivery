#!/bin/bash

SWARM_WORKER_COUNT=4
SECURITY_GROUP=${STACK_NAME}-swarmmanager-sg

eval $(docker-machine env aws-${STACK_NAME}-swarm-manager)

# Remove master nodes
docker-machine rm -f aws-${STACK_NAME}-swarm-manager

# Remove all worker nodes
for i in $(seq "${SWARM_WORKER_COUNT}"); do
  docker-machine rm -f aws-${STACK_NAME}-swarm-worker${i}
  aws ec2 delete-key-pair --key-name aws-${STACK_NAME}-swarm-worker${i}
done

echo "terminating aws-${STACK_NAME}-swarm-manager node..."
sleep 120
aws ec2 delete-security-group --group-name ${SECURITY_GROUP}
