## Deploy Swarm Cluster

#### Virtual Box Local Environment

```
source ./environment/common.sh
source ./environment/local.sh
./vb/setup.sh
./deploy.sh
```

#### AWS cloud Staging Environment

##### Provision Nodes, setup swarm cluster & deploy services

```
./aws/setup.sh apistaging
./deploy.sh apistaging
```

## Tear down Swarm Cluster

#### Virtual Box

```
./vb/teardown.sh
```

#### AWS cloud

##### Staging/Pre-Prod

```
./aws/terminate.sh
```
