##### Client Details

```
Client name: kickster-app
Client ID: oCL222XBOGgw0x4IqTz7IL29geD63i4e
Client Secret: NMjoxGUirHnM8J3IMEQmQd8vhgw2QV7G6OOjPk3K9Mf_nQ6dbVMoyr8XPAiCSRBI
Redirect URIs: https://example.com/kickster-app
Issuer: https://kickster-app.auth0.com/
Identity Provider Name: Auth0
Provider Location: US

```

##### Authorization Endpoint

```
https://kickster-app.auth0.com/authorize
```

##### Token Endpoint:

```
https://kickster-app.auth0.com/oauth/token
```

##### JSON Web Key Set EndPoint:

```
https://kickster-app.auth0.com/.well-known/jwks.json
```

##### User Info Endpoint:

```
https://kickster-app.auth0.com/userinfo
```

##### Get Authorization code

###### Request:

```
curl https://kickster-app.auth0.com/authorize?response_type=code&client_id=oCL222XBOGgw0x4IqTz7IL29geD63i4e&scope=openid&redirect_uri=https://example.com/kickster-app&state=1234
```

##### Get Token using `code` grant type:

###### Request:

```
curl -X POST -u "oCL222XBOGgw0x4IqTz7IL29geD63i4e:NMjoxGUirHnM8J3IMEQmQd8vhgw2QV7G6OOjPk3K9Mf_nQ6dbVMoyr8XPAiCSRBI" -d "grant_type=authorization_code&code=Go7hoEr8hQf8EMb8&state=1234&scope=openid&redirect_uri=https://example.com/kickster-app" "https://kickster-app.auth0.com/oauth/token" | jq .
```

###### Response:

```
{
  "access_token": "wiTDtuUNaUNNtByD",
  "expires_in": 86400,
  "id_token": "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImtpZCI6Ik9EazJOa1pCUWpRNFF6aEdSa00yUkVNeU1ESXpOVEEzTVRNeFJqQXlOa1ZFTXpWQ056RTROUSJ9.eyJpc3MiOiJodHRwczovL2tpY2tzdGVyLWFwcC5hdXRoMC5jb20vIiwic3ViIjoiYXV0aDB8NTg2MjMzYjI5NThjNDY3MjQ0YzA3N2Y3IiwiYXVkIjoib0NMMjIyWEJPR2d3MHg0SXFUejdJTDI5Z2VENjNpNGUiLCJleHAiOjE0ODMxNTkxOTEsImlhdCI6MTQ4MzEyMzE5MX0.UuK_3XrEg3Ti7HczIHNnrFUhCN6VMTExEg4c6Jusl8HaT9ZueLCyh2o5IY-9LesosdmumPE_kpRaPGB5Mm67zCL3odB3LZFIOefl3wjW4e4v30t07VZAmdC-PhohD1fXfTbEApSZn2i0rdD5TlRUGtWVZLsAQoJ9PgKLoHvkVBplVT03OBX_ZhtKSpCMH3JAdZNXxTNFMbwncYscUKfAnn6QAz07GsJ7wtW8eYbcSoGKYlZp6XCPwdT2lJppiBd6vLNfQQRHX0prvGuFIlgXKZOXZ6cJz8HshhMECo3kmuqhqth2_SE45sApiMXu7SGdICO33yxKX0A4ZZBLMiND5Q",
  "token_type": "Bearer"
}

```
#### User Flow: Password Grant

##### Get Token using `Password` grant type

###### Request:

```
curl -u "7C4F4zcN4vAVEOoXJ1jO2m25lVoejAUl:2r8eb9-DX2YB8YEIOBeghzIvzNqnoOdsxsOEx3okxG2Xf2sC_SW2HWYzatjlivbF" -d "grant_type=password&scope=openid&username=salsiddiqui0@gmail.com&password=kickster123" "https://kickster-app.auth0.com/oauth/token" | jq .
```

#### User Flow: Machine to Machine

##### Get Token using `client_credentials` using grant type

###### Request:

```
curl -u "oCL222XBOGgw0x4IqTz7IL29geD63i4e:NMjoxGUirHnM8J3IMEQmQd8vhgw2QV7G6OOjPk3K9Mf_nQ6dbVMoyr8XPAiCSRBI" -d "grant_type=client_credentials&scope=openid" "https://kickster-app.auth0.com/oauth/token" | jq .
```

###### Response:

```
{
  "access_token": "XW3hZP8NKUKB5XjMyLbSZE1SDAu8L0H1ihNAmkmP6ktd2piquFweQDfQmVDsSo0k",
  "expires_in": 86400,
  "token_type": "Bearer"
}
```

#### User Flow: Refresh Token

###### Request

```
$ curl https://kickster-app.auth0.com/oauth/token?grant_type=refresh_token&client_id=oCL222XBOGgw0x4IqTz7IL29geD63i4e&client_secret=NMjoxGUirHnM8J3IMEQmQd8vhgw2QV7G6OOjPk3K9Mf_nQ6dbVMoyr8XPAiCSRBI&refresh_token=

```

###### Response

```
```
