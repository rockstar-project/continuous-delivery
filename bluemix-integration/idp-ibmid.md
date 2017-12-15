##### Client Details

```
Client ID: N2EyNTliMTUtZWExOC00
Client Secret: NDBhMWY0MjEtMzI2Yy00
Technology: OpenID Connect
Application Location : North America
Phase : Test (uses test LDAP)
Client Name : kickster-app
Name : w3id Test
Site : United States
OIDC Type : ISAM-OIDC

```

##### Endpoints

Authorization Endpoint
https://w3id-test.sso.ibm.com/isam/oidc/endpoint/amapp-runtime-oidcidp/authorize
Token EndPoint:*
https://w3id-test.sso.ibm.com/isam/oidc/endpoint/amapp-runtime-oidcidp/token
Introspection EndPoint:*
https://w3id-test.sso.ibm.com/isam/oidc/endpoint/amapp-runtime-oidcidp/introspect


User Info Endpoint:

```

```

##### Authorize code endpoint

Request:

```
curl https://w3id-test.sso.ibm.com/isam/oidc/endpoint/amapp-runtime-oidcidp/authorize?response_type=code&client_id=MmE3YTUyMGYtMDc0MC00&scope=openid&redirect_url=https://example.com/regionalapi&state=1234
```

##### Get Token using `authorization_code` grant type

###### Request:

```
curl -X POST -u "MmE3YTUyMGYtMDc0MC00:MWE1ODUwZjctZjNkMi00" -d "grant_type=authorization_code&code=VLhD9ehjZylj9eDLwS7hYLqgEojGJJ&state=1234&scope=openid&redirect_url=https://example.com/regionalapi" "https://prepiam.toronto.ca.ibm.com/idaas/oidc/endpoint/default/token" | jq .
```

###### Response:

```
{
  "access_token": "3m88TLLyNriFihXfLGYdPRhXx5tq2mRdI9wcXRGW",
  "token_type": "Bearer",
  "expires_in": 3599,
  "scope": "openid",
  "refresh_token": "lxn3t05b90QfKTuN1Ml7AZmhYXX3hjmsvLeo1ucQgE1wSWI8vW",
  "id_token": "eyJhbGciOiJSUzI1NiJ9.eyJpc3MiOiJodHRwczovL3ByZXBpYW0udG9yb250by5jYS5pYm0uY29tIiwiZXh0Ijoie1widGVuYW50SWRcIjpcInByZXBpYW0udG9yb250by5jYS5pYm0uY29tXCJ9IiwiYXRfaGFzaCI6Ii1MeXMxMVkwbFh0TEFWVnR2NlFtamciLCJzdWIiOiJzc2lkZGlxQHVzLmlibS5jb20iLCJlbWFpbF92ZXJpZmllZCI6InRydWUiLCJyZWFsbU5hbWUiOiJ3d3cuaWJtLmNvbSIsInVuaXF1ZVNlY3VyaXR5TmFtZSI6IjUxSzdXMzVKRzAiLCJwcmVmZXJyZWRfdXNlcm5hbWUiOiJzc2lkZGlxQHVzLmlibS5jb20iLCJnaXZlbl9uYW1lIjoiU2FsIiwiYXVkIjoiWVRoaE1tSmhNak10TXpkbVppMDAiLCJuYW1lIjoiU2FsIFNpZGRpcXVpIiwiZXhwIjoxNDgzMDQ3MzIyLCJpYXQiOjE0ODMwNDM3MjIsImZhbWlseV9uYW1lIjoiU2lkZGlxdWkiLCJlbWFpbCI6InNzaWRkaXFAdXMuaWJtLmNvbSJ9.Jag4EcGQW8dRznHPpZgtHvLLSOYfpaVEt89LgLB8cnDE3iqW70kxyO_R5oliDERRmchleoqiSUkxAalglwhP4Gnm6j00X90pDb6_suK5hmR6Rez-eRkJf0KioP1Z67czvORKqNp8LkB4jJ4AuZorOthTYiIZ6UNXlb8_hrbEfpxJEthi90pg29QSM2AzqVeIesnkj25PwHv9tUmEYLXfb5-uFsOA5jLdLS4-budi_xl9fefIq5ektWqhVTNfIyaNEkmcomF9v9D5zhp7RVbzy5fJ2yC_o3BAWxboYK3eXPewq7GuLgjzvhUc4OvL6rh3xCcW4bqim7Fg7zzvMoCyIg"
}
```

##### Get Token using `password` grant type

###### Request:

```
curl -u '${IDP_CLIENT_ID}:${$IDP_CLIENT_SECRET}' -d 'grant_type=password&scope=openid&username=${APP_USER}&password=${APP_PASSWORD}' "https://prepiam.toronto.ca.ibm.com/idaas/oidc/endpoint/default/token" | jq .
```
curl -H "Content-Type: application/json" -u 'N2EyNTliMTUtZWExOC00:NDBhMWY0MjEtMzI2Yy00' -d 'grant_type=password&scope=openid&username=ssiddiq@us.ibm.com&password=tehreem123' "https://w3id-test.sso.ibm.com/isam/oidc/endpoint/amapp-runtime-oidcidp/token" | jq .
###### Response:

```
{
  "access_token": "fYFcz0F0jYp38Dh12HVCfdaElD39uuoGEzFP02Eb",
  "token_type": "Bearer",
  "expires_in": 3599,
  "scope": "openid",
  "refresh_token": "5jPceJGamsqvKN3THyvvhTNN7S9Qdk7QMezXa2OObBv8mrfJOh"
}
```

##### Get Token using `client_credentials` grant type

Request:

```
curl -H "Accept: application/json" -u "N2EyNTliMTUtZWExOC00:NDBhMWY0MjEtMzI2Yy00" -d "grant_type=client_credentials&scope=openid" "https://w3id-test.sso.ibm.com/isam/oidc/endpoint/amapp-runtime-oidcidp/token"
```

Response:

```
{
  "access_token": "TbhO6PrNeHC4lUFnRxcf9WCMoLHETVB9Tl6xiwFQ",
  "token_type": "Bearer",
  "expires_in": 3599,
  "scope": "openid"
}
```
