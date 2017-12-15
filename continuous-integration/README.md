# Setup Continuous Integration

#### Clone repository

```
$ git clone https://github.ibm.com/kickster/continuous-delivery.git
$ cd continuous-delivery/continuous-integration/templates
```

#### Generate CI Setup script

```
$ mustache metadata.json setup-ci.mustache > setup-ci.sh
$ chmod +x setup-ci.sh
```

#### Configure CI Environment

```
$ source ~/.kickster/dev_secrets.env
```

#### Run CI Setup

```
$ ./setup-ci.sh
```
