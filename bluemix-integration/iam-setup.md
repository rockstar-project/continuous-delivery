## Setting up access control for Kickster API
[Step by Step Instructions are found here](https://console.stage1.ng.bluemix.net/docs/developing/Access-Management/index.html#setup_access_mgmt)

##### Request an Access Token

Request:

```
curl -X POST -H "Authorization: Basic Y2Y6" -H "Content-Type: application/x-www-form-urlencoded" -d "grant_type=password&username=$APP_USER&password=$APP_PASSWORD" "https://login.stage1.ng.bluemix.net/UAALoginServerWAR/oauth/token" | jq .
```

Response:

```
{
  "access_token": "eyJhbGciOiJIUzI1NiJ9.eyJqdGkiOiI4NDYzZTVhMi1lOWM0LTRhMTUtYjJiZi1lOWU4MTY0MWQzNGUiLCJzdWIiOiJhMGQ2N2FmNS0yMDZmLTQ1MDUtYjEzZi05MjFhYTRkZTQxMzYiLCJzY29wZSI6WyJvcGVuaWQiLCJ1YWEudXNlciIsImNsb3VkX2NvbnRyb2xsZXIucmVhZCIsInBhc3N3b3JkLndyaXRlIiwiY2xvdWRfY29udHJvbGxlci53cml0ZSJdLCJjbGllbnRfaWQiOiJjZiIsImNpZCI6ImNmIiwiYXpwIjoiY2YiLCJncmFudF90eXBlIjoicGFzc3dvcmQiLCJ1c2VyX2lkIjoiYTBkNjdhZjUtMjA2Zi00NTA1LWIxM2YtOTIxYWE0ZGU0MTM2Iiwib3JpZ2luIjoidWFhIiwidXNlcl9uYW1lIjoic3NpZGRpcUB1cy5pYm0uY29tIiwiZW1haWwiOiJzc2lkZGlxQHVzLmlibS5jb20iLCJhdXRoX3RpbWUiOjE0ODI5OTMyMTQsInJldl9zaWciOiJiZmQxOGQ4ZSIsImlhdCI6MTQ4Mjk5MzIxNCwiZXhwIjoxNDg0MjAyODE0LCJpc3MiOiJodHRwczovL3VhYS5zdGFnZTEubmcuYmx1ZW1peC5uZXQvb2F1dGgvdG9rZW4iLCJ6aWQiOiJ1YWEiLCJhdWQiOlsiY2YiLCJvcGVuaWQiLCJ1YWEiLCJjbG91ZF9jb250cm9sbGVyIiwicGFzc3dvcmQiXX0.4g3PEPHpB4TQfAX48DQysZyvY4nHuzFUtoxPW1Y3bt4",
  "token_type": "bearer",
  "refresh_token": "eyJhbGciOiJIUzI1NiJ9.eyJqdGkiOiI2YTU4MGNhYy04MTljLTQzMjMtODc1ZC02Y2ExYjRhZGE5ZmUtciIsInN1YiI6ImEwZDY3YWY1LTIwNmYtNDUwNS1iMTNmLTkyMWFhNGRlNDEzNiIsInNjb3BlIjpbIm9wZW5pZCIsInVhYS51c2VyIiwiY2xvdWRfY29udHJvbGxlci5yZWFkIiwicGFzc3dvcmQud3JpdGUiLCJjbG91ZF9jb250cm9sbGVyLndyaXRlIl0sImlhdCI6MTQ4Mjk5MzIxNCwiZXhwIjoxNDg1NTg1MjE0LCJjaWQiOiJjZiIsImNsaWVudF9pZCI6ImNmIiwiaXNzIjoiaHR0cHM6Ly91YWEuc3RhZ2UxLm5nLmJsdWVtaXgubmV0L29hdXRoL3Rva2VuIiwiemlkIjoidWFhIiwiZ3JhbnRfdHlwZSI6InBhc3N3b3JkIiwidXNlcl9uYW1lIjoic3NpZGRpcUB1cy5pYm0uY29tIiwib3JpZ2luIjoidWFhIiwidXNlcl9pZCI6ImEwZDY3YWY1LTIwNmYtNDUwNS1iMTNmLTkyMWFhNGRlNDEzNiIsInJldl9zaWciOiJiZmQxOGQ4ZSIsImF1ZCI6WyJjZiIsIm9wZW5pZCIsInVhYSIsImNsb3VkX2NvbnRyb2xsZXIiLCJwYXNzd29yZCJdfQ.Lx1EHA4ESskzmtIZ1XvbkTax6odKoSYgsoR_3LFyqvE",
  "expires_in": 1209599,
  "scope": "openid uaa.user cloud_controller.read password.write cloud_controller.write",
  "jti": "8463e5a2-e9c4-4a15-b2bf-e9e81641d34e"
}
```

Set Access Token in the environment

```
$ export TOKEN=<access_token_value>
```

##### Get Organization Guid

Request:

```
curl -H "Authorization: bearer $TOKEN" "https://api.stage1.ng.bluemix.net/v2/organizations" | jq .
```

Response:

```
{
  "total_results": 1,
  "total_pages": 1,
  "prev_url": null,
  "next_url": null,
  "resources": [
    {
      "metadata": {
        "guid": "30af79eb-aa5e-4d72-b66d-5d07d3661c2d",
        "url": "/v2/organizations/30af79eb-aa5e-4d72-b66d-5d07d3661c2d",
        "created_at": "2016-11-01T00:08:09Z",
        "updated_at": null
      },
      "entity": {
        "name": "ssiddiq",
        "billing_enabled": false,
        "quota_definition_guid": "fd77733b-34b2-4c23-b88b-916eddbcac5b",
        "status": "active",
        "quota_definition_url": "/v2/quota_definitions/fd77733b-34b2-4c23-b88b-916eddbcac5b",
        "spaces_url": "/v2/organizations/30af79eb-aa5e-4d72-b66d-5d07d3661c2d/spaces",
        "domains_url": "/v2/organizations/30af79eb-aa5e-4d72-b66d-5d07d3661c2d/domains",
        "private_domains_url": "/v2/organizations/30af79eb-aa5e-4d72-b66d-5d07d3661c2d/private_domains",
        "users_url": "/v2/organizations/30af79eb-aa5e-4d72-b66d-5d07d3661c2d/users",
        "managers_url": "/v2/organizations/30af79eb-aa5e-4d72-b66d-5d07d3661c2d/managers",
        "billing_managers_url": "/v2/organizations/30af79eb-aa5e-4d72-b66d-5d07d3661c2d/billing_managers",
        "auditors_url": "/v2/organizations/30af79eb-aa5e-4d72-b66d-5d07d3661c2d/auditors",
        "app_events_url": "/v2/organizations/30af79eb-aa5e-4d72-b66d-5d07d3661c2d/app_events",
        "space_quota_definitions_url": "/v2/organizations/30af79eb-aa5e-4d72-b66d-5d07d3661c2d/space_quota_definitions"
      }
    }
  ]
}
```

##### Create a Service

Request:

```
curl -X POST -H "Authorization: bearer $TOKEN" -H "Content-Type: application/json" -d '{ "name": "kickster", "description": "A model driven platform providing automatic generation of software artifacts including api-first design, cloud-native RESTful microservices and DevOps scripts.","boundTo": "crn:v1:staging:public:kickster:us-south:o/30af79eb-aa5e-4d72-b66d-5d07d3661c2d:6e2a467a-25aa-43af-a371-5ec06a355fd1::"}' "https://iam.stage1.ng.bluemix.net/serviceids" | jq .
```

Response:

```
{
  "metadata": {
    "uuid": "ServiceId-3952384d-59ea-4fa3-80e9-7089c13bc659",
    "crn": "crn:v1:staging:public:iam:us-south:o/30af79eb-aa5e-4d72-b66d-5d07d3661c2d::serviceid:ServiceId-3952384d-59ea-4fa3-80e9-7089c13bc659",
    "version": "1-90b85550a1af94bda6b5ed2f7f433d6d"
  },
  "entity": {
    "boundTo": "crn:v1:staging:public:kickster:us-south:o/30af79eb-aa5e-4d72-b66d-5d07d3661c2d:6e2a467a-25aa-43af-a371-5ec06a355fd1::",
    "name": "kickster",
    "description": "A model driven platform providing automatic generation of software artifacts including api-first design, cloud-native RESTful microservices and DevOps scripts."
  }
}
```

##### Create an API Key

Request:

```
curl -X POST -H "Authorization: bearer $TOKEN" -H "Content-Type: application/json" -d '{"boundTo": "crn:v1:staging:public:iam:us-south:o/30af79eb-aa5e-4d72-b66d-5d07d3661c2d::serviceid:ServiceId-3952384d-59ea-4fa3-80e9-7089c13bc659", "name": "kickster-api-key", "description": "Kickster API Key"}' "https://iam.stage1.ng.bluemix.net/apikeys" | jq .
```

Response:

```
{
  "metadata": {
    "uuid": "ApiKey-dda6989b-1a06-4489-bd10-882ac1ab1f35",
    "crn": "crn:v1:staging:public:iam:us-south:o/30af79eb-aa5e-4d72-b66d-5d07d3661c2d::apikey:ApiKey-dda6989b-1a06-4489-bd10-882ac1ab1f35",
    "version": "1-e012dc1c60e56aca5984c585015909c2"
  },
  "entity": {
    "boundTo": "crn:v1:staging:public:iam:us-south:o/30af79eb-aa5e-4d72-b66d-5d07d3661c2d::serviceid:ServiceId-3952384d-59ea-4fa3-80e9-7089c13bc659",
    "name": "kickster-api-key",
    "description": "Kickster API Key",
    "format": "APIKEY",
    "apiKey": "++jHVnvb7ifr7mIFmIJvHI0ZIY4D8vNVeg6KjBmP3L4="
  }
}
```

##### Request IAM Access Token

Request:

```
curl -X POST -H "Content-Type: application/x-www-form-urlencoded" -H "Accept: application/json" -d "grant_type%3Durn%3Aibm%3Aparams%3Aoauth%3Agrant-type%3Aapikey%26apikey%3D++jHVnvb7ifr7mIFmIJvHI0ZIY4D8vNVeg6KjBmP3L4%3D" "https://iam.stage1.ng.bluemix.net/oidc/token" | jq .
```

Response:

```
{
  "access_token": "eyJraWQiOiIyMDE2MTIwMS0wMDowMDowMCIsImFsZyI6IlJTMjU2In0.eyJyZWFsbWlkIjoiaW50ZXJuYWwiLCJpZGVudGlmaWVyIjoiU2VydmljZUlkLTM5NTIzODRkLTU5ZWEtNGZhMy04MGU5LTcwODljMTNiYzY1OSIsInN1YiI6IlNlcnZpY2VJZC0zOTUyMzg0ZC01OWVhLTRmYTMtODBlOS03MDg5YzEzYmM2NTkiLCJzdWJfdHlwZSI6IlNlcnZpY2VJZCIsImFjY291bnQiOnsiYnNzIjoiZDE3NTg5OGJkZDMyN2UwZWJmMDdmZDI5MzFkZDU5NmUifSwibWZhIjp7fSwiaWF0IjoxNDgyOTk3MTU3LCJleHAiOjE0ODMwMDA3NTcsImlzcyI6Imh0dHBzOi8vaWFtLnN0YWdlMS5uZy5ibHVlbWl4Lm5ldC9vaWRjL3Rva2VuIiwiZ3JhbnRfdHlwZSI6InVybjppYm06cGFyYW1zOm9hdXRoOmdyYW50LXR5cGU6YXBpa2V5Iiwic2NvcGUiOiJvcGVuaWQiLCJjbGllbnRfaWQiOiJkZWZhdWx0In0.wW1IwdRoX434JPe9YwgxrBibWrgfVTISKqtPYq_4G1-x68COVtv27SBfQ1PZ2CbORvxAgt5i-3rS3AXTkRmp3OA14pgNeYRioloA-wrHGNVIrrEmgcgHx3RkGgQ9hyd81Y_ROfLqe-hzJmWvPsMnfsW28WIGIjSIymhqHl63fm18ktoPrZ_yJz_OqeQk2TM7sRRANnKJonvBGjdEzo33zhdTQxUqRBqu47dIyOSuwDEwkFsBWb6TYH57wUAzO_cBy-JMPLxDMNs-YPU06pjKH932unoOGaSehJRFDO24n4sxkdjcrNxB25597Hh2Gq-yOnjeOys9CIf8rNrVmkMQ1g",
  "token_type": "Bearer",
  "expires_in": 3600,
  "expiration": 1483000757
}
```

Set IAM_TOKEN environment variable

```
$ export IAM_TOKEN=<access_token_value>
```

Request:

```
$ curl -X GET -H 'Authorization: eyJraWQiOiIyMDE2MTIwMS0wMDowMDowMCIsImFsZyI6IlJTMjU2In0' 'https://iampap.stage1.ng.bluemix.net/acms/v1/scopes/global/service_ids/ServiceId-3952384d-59ea-4fa3-80e9-7089c13bc659/policies' | jq .
```

#### View roles

Request:

```
curl -X GET --header 'Accept: application/json' --header "Authorization: $IAM_TOKEN" 'https://iampap.stage1.ng.bluemix.net/acms/v1/roles'
```

Response:

```
{
  "systemDefinedRoles": [
    {
      "crn": "crn:v1:bluemix:public:iam::::role:Viewer",
      "displayName": "Viewer",
      "description": "Viewer"
    },
    {
      "crn": "crn:v1:bluemix:public:iam::::role:Administrator",
      "displayName": "Administrator",
      "description": "Administrator"
    },
    {
      "crn": "crn:v1:bluemix:public:iam::::role:Editor",
      "displayName": "Editor",
      "description": "Editor"
    },
    {
      "crn": "crn:v1:bluemix:public:iam::::role:Operator",
      "displayName": "Operator",
      "description": "Operator"
    },
    {
      "crn": "crn:v1:bluemix:public:iam::::role:BillingAdministrator",
      "displayName": "Billing Administrator",
      "description": "Billing Administrator"
    }
  ]
}
```

#### Mapping Service Actions to roles

Request:

```
curl -X PUT -H 'Content-Type: application/json' -H 'Accept: application/json' -H 'Authorization: $IAM_TOKEN' -d '{
 "displayName": {
   "default": "Kickster API Service"
 },
 "actions": [{
   "id": kickster.model.read,
   "displayName": {
     "default": Read model
   },
   "roles": ["crn:v1:bluemix:public:iam::::role:Viewer","crn:v1:bluemix:public:iam::::role:Editor","crn:v1:bluemix:public:iam::::role:Administrator"]
 }]
}' 'https://iampap.stage1.ng.bluemix.net/acms/v1/services/kickster'
```
