#!/bin/bash

echo "===== Building docker swarm ======"

# Set docker-machine options
MASTER_OPTIONS="--driver amazonec2
                  --amazonec2-access-key ${AWS_ACCESS_KEY_ID}
                  --amazonec2-secret-key ${AWS_SECRET_ACCESS_KEY}
                  --amazonec2-region ${AWS_REGION}
                  --amazonec2-zone ${AWS_AVAILABILITY_ZONE}
                  --amazonec2-vpc-id ${AWS_VPC_ID}
                  --amazonec2-subnet ${AWS_SUBNET}"

WORKER_OPTIONS="--driver amazonec2
                  --amazonec2-access-key ${AWS_ACCESS_KEY_ID}
                  --amazonec2-secret-key ${AWS_SECRET_ACCESS_KEY}
                  --amazonec2-region ${AWS_REGION}
                  --amazonec2-zone ${AWS_AVAILABILITY_ZONE}
                  --amazonec2-vpc-id ${AWS_VPC_ID}
                  --amazonec2-subnet ${AWS_SUBNET}"

# Create master node
MASTER_NODE=rockstarproject-master
docker-machine create ${MASTER_OPTIONS} ${MASTER_NODE}
docker-machine ssh ${MASTER_NODE} sysctl -w vm.max_map_count=262144
cat ./id_rsa.pub | docker-machine ssh ${MASTER_NODE} "cat >> ~/.ssh/authorized_keys"
eval $(docker-machine env ${MASTER_NODE})

# get swarm master ip
SWARM_MASTER_IP=$(docker-machine ip ${MASTER_NODE})
echo "===== Swarm master IP: [${SWARM_MASTER_IP}]"

# initialise swarm
docker swarm init --listen-addr=${SWARM_MASTER_IP}:2733 --advertise-addr=${SWARM_MASTER_IP}:2733

# get worker join token
SWARM_TOKEN_WORKER=$(docker swarm join-token -q worker)
echo "===== Swarm worker join token: [${SWARM_TOKEN_WORKER}]"

# Create workers node and join the swarm
for i in $(seq "${SWARM_NUM_WORKER}"); do
  WORKER_NODE=rockstarproject-worker-${i}
  docker-machine create ${WORKER_OPTIONS} ${WORKER_NODE}
  docker-machine ssh ${WORKER_NODE} sysctl -w vm.max_map_count=262144
  cat ./id_rsa.pub | docker-machine ssh ${WORKER_NODE} "cat >> ~/.ssh/authorized_keys"
  eval $(docker-machine env ${WORKER_NODE})
  docker swarm join --token ${SWARM_TOKEN_WORKER} ${SWARM_MASTER_IP}:2733
done

# Show swarm cluster
eval $(docker-machine env ${MASTER_NODE})
echo "===== Local Swarm Cluster"
docker node ls
