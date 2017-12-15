## Kickster Service & Resources
[CRN Specification is available here](https://github.ibm.com/ibmcloud/builders-guide/blob/master/specifications/crn/CRN.md)

##### Service CRN

```
crn:v1:staging:public:kickster:us-south:o/30af79eb-aa5e-4d72-b66d-5d07d3661c2d:6e2a467a-25aa-43af-a371-5ec06a355fd1::
```

##### Model Resource CRN

```
crn:v1:staging:public:kickster:us-south:o/30af79eb-aa5e-4d72-b66d-5d07d3661c2d:6e2a467a-25aa-43af-a371-5ec06a355fd1::models
```

##### Template Resource CRN
```
crn:v1:staging:public:kickster:us-south:o/30af79eb-aa5e-4d72-b66d-5d07d3661c2d:6e2a467a-25aa-43af-a371-5ec06a355fd1::templates
```

##### Artifact Resource CRN

```
crn:v1:staging:public:kickster:us-south:o/30af79eb-aa5e-4d72-b66d-5d07d3661c2d:6e2a467a-25aa-43af-a371-5ec06a355fd1:artifacts
```

### Mapping Service Actions to Roles

| API Endpoint           | Service Action           | IAM System Defined Roles      |
|------------------------|--------------------------|-------------------------------|
| POST /models           | kickster.model.create    | Administrator                 |
| GET /models            | kickster.model.read      | Viewer, Editor, Administrator |
| PUT /models/{id}       | kickster.model.update    | Editor, Administrator         |
| DELETE /models/{id}    | kickster.model.delete    | Administrator                 |
| GET /models/{id}       | kickster.model.read      | Viewer, Editor, Administrator |
| POST /templates        | kickster.template.create | Administrator                 |
| GET /templates         | kickster.template.read   | Viewer, Editor, Administrator |
| PUT /templates/{id}    | kickster.template.update | Editor, Administrator         |
| DELETE /templates/{id} | kickster.template.delete | Administrator                 |
| GET /templates/{id}    | kickster.template.read   | Viewer, Editor, Administrator |
| POST /artifacts        | kickster.artifact.create | Viewer, Editor, Administrator |