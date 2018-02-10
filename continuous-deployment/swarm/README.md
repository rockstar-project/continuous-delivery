## Deploy Swarm Cluster

#### Virtual Box

```
./vb/setup.sh apistaging
./deploy.sh apistaging
```

#### AWS cloud

##### Staging/Pre-Prod

```
./aws/setup.sh apistaging
./deploy.sh apistaging
```

## Terminate Swarm Cluster

#### Virtual Box

```
./remove.sh apistaging
./vb/terminate.sh apistaging
```

#### AWS cloud

##### Staging/Pre-Prod

```
./remove.sh apistaging
./aws/terminate.sh apistaging
```
