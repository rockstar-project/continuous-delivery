#!/bin/bash

STACK_NAME=$1
SWARM_PORT=2377
# Create the docker swarm manager node first.
docker-machine create --driver virtualbox ${STACK_NAME}-swarm-manager

# Get the IP address of the manager node.
SWARM_MANAGER_IP=$(docker-machine ip ${STACK_NAME}-swarm-manager)

# Create the three worker nodes.
docker-machine create --driver virtualbox ${STACK_NAME}-swarm-worker1
docker-machine create --driver virtualbox ${STACK_NAME}-swarm-worker2
docker-machine create --driver virtualbox ${STACK_NAME}-swarm-worker3

# Get the IP address of the worker nodes.

SWARM_WORKER1_IP=$(docker-machine ip ${STACK_NAME}-swarm-worker1)
SWARM_WORKER2_IP=$(docker-machine ip ${STACK_NAME}-swarm-worker2)
SWARM_WORKER3_IP=$(docker-machine ip ${STACK_NAME}-swarm-worker3)

# Point your docker client to the swarm manager.
eval $(docker-machine env ${STACK_NAME}-swarm-manager)

# Initialize Swarm mode.
docker swarm init --advertise-addr ${SWARM_MANAGER_IP} --listen-addr ${SWARM_MANAGER_IP}:${SWARM_PORT}

export TOKEN=$(docker swarm join-token -q worker)

# Point your docker client to the swarm worker1
eval $(docker-machine env ${STACK_NAME}-swarm-worker1)
docker swarm join --token $TOKEN --listen-addr ${SWARM_WORKER1_IP}:${SWARM_PORT} ${SWARM_MANAGER_IP}:${SWARM_PORT}

# Point your docker client to the swarm worker2
eval $(docker-machine env ${STACK_NAME}-swarm-worker2)
docker swarm join --token $TOKEN --listen-addr ${SWARM_WORKER2_IP}:${SWARM_PORT} ${SWARM_MANAGER_IP}:${SWARM_PORT}

# Point your docker client to the swarm worker3
eval $(docker-machine env ${STACK_NAME}-swarm-worker3)
docker swarm join --token $TOKEN --listen-addr ${SWARM_WORKER3_IP}:${SWARM_PORT} ${SWARM_MANAGER_IP}:${SWARM_PORT}

# Verify the cluster.
eval $(docker-machine env ${STACK_NAME}-swarm-manager)
docker node ls
docker node update --label-add type=gateway ${STACK_NAME}-swarm-manager
