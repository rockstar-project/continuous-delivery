#!/bin/bash

set -e

STACK_NAME=apistaging
HOSTED_DOMAIN=rock-star.io
EIP_ALLOCATION_ID=eipalloc-f65b86cb
SWARM_WORKER_COUNT=4
SWARM_PORT=2377
REGION=us-west-1
VPC=vpc-3d16dc59
SUBNET=subnet-5aaa1f02
ZONE=c
SECURITY_GROUP=${STACK_NAME}-swarmmanager-sg

docker-machine create -d amazonec2 --amazonec2-vpc-id $VPC --amazonec2-region $REGION --amazonec2-zone $ZONE --amazonec2-instance-type t2.micro --amazonec2-subnet-id $SUBNET --amazonec2-security-group $SECURITY_GROUP aws-${STACK_NAME}-swarm-manager

SECURITY_GROUP_ID=$(aws ec2 describe-security-groups --filter "Name=group-name,Values=${SECURITY_GROUP}" | jq -r .SecurityGroups[0].GroupId)
aws ec2 authorize-security-group-ingress --group-id $SECURITY_GROUP_ID --protocol tcp --port ${SWARM_PORT} --source-group $SECURITY_GROUP_ID
aws ec2 authorize-security-group-ingress --group-id $SECURITY_GROUP_ID --protocol tcp --port 7946 --source-group $SECURITY_GROUP_ID
aws ec2 authorize-security-group-ingress --group-id $SECURITY_GROUP_ID --protocol udp --port 7946 --source-group $SECURITY_GROUP_ID
aws ec2 authorize-security-group-ingress --group-id $SECURITY_GROUP_ID --protocol tcp --port 4789 --source-group $SECURITY_GROUP_ID
aws ec2 authorize-security-group-ingress --group-id $SECURITY_GROUP_ID --protocol udp --port 4789 --source-group $SECURITY_GROUP_ID
aws ec2 authorize-security-group-ingress --group-id $SECURITY_GROUP_ID --protocol tcp --port 80 --cidr 0.0.0.0/0
aws ec2 authorize-security-group-ingress --group-id $SECURITY_GROUP_ID --protocol tcp --port 8761 --cidr 0.0.0.0/0

echo "getting aws-${STACK_NAME}-swarm-manager internal ip address..."
export DESCRIBE_INSTANCE_RESULT_JSON=$(aws ec2 describe-instances --filters "Name=tag:Name,Values=aws-${STACK_NAME}-swarm-manager" "Name=instance-state-name,Values=running")
export SWARM_MANAGER_INTERNAL_IP=$(echo $DESCRIBE_INSTANCE_RESULT_JSON | jq -r .Reservations[0].Instances[0].PrivateIpAddress)
export SWARM_MANAGER_INSTANCE_ID=$(echo $DESCRIBE_INSTANCE_RESULT_JSON | jq -r .Reservations[0].Instances[0].InstanceId)
echo "successfully retrieved aws-${STACK_NAME}-swarm-manager internal ip address ${SWARM_MANAGER_INTERNAL_IP}"

eval $(docker-machine env aws-${STACK_NAME}-swarm-manager)
docker swarm init --advertise-addr=${SWARM_MANAGER_INTERNAL_IP}
export TOKEN=$(docker swarm join-token -q worker)

for i in $(seq "${SWARM_WORKER_COUNT}"); do
  docker-machine create -d amazonec2 --amazonec2-vpc-id $VPC --amazonec2-region $REGION --amazonec2-zone $ZONE --amazonec2-instance-type t2.micro --amazonec2-subnet-id $SUBNET --amazonec2-security-group $SECURITY_GROUP aws-${STACK_NAME}-swarm-worker${i}
  eval $(docker-machine env aws-${STACK_NAME}-swarm-worker${i})
  docker swarm join --token $TOKEN ${SWARM_MANAGER_INTERNAL_IP}:${SWARM_PORT}
done

aws ec2 associate-address --allocation-id ${EIP_ALLOCATION_ID} --instance-id ${SWARM_MANAGER_INSTANCE_ID}
docker-machine regenerate-certs aws-${STACK_NAME}-swarm-manager

# verify the cluster

eval $(docker-machine env aws-${STACK_NAME}-swarm-manager)
docker node ls

unset SWARM_MANAGER_INTERNAL_IP
unset SWARM_MANAGER_INSTANCE_ID
unset DESCRIBE_INSTANCE_RESULT_JSON
unset TOKEN
