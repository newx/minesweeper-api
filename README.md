# Minesweeper API

- [Minesweeper API](#minesweeper-api)
  - [Install and Setup](#install-and-setup)
  - [REST API](#rest-api)
    - [Users](#users)
      - [Create a new user](#create-a-new-user)
      - [Sign In](#sign-in)
      - [Access user data via JWT authentication](#access-user-data-via-jwt-authentication)
      - [Sign Out](#sign-out)
  - [GrahpQL API](#grahpql-api)
    - [GraphiQL console](#graphiql-console)
## Install and Setup

## REST API

This API is used to sign up, sign in and sign out users.

### Users

#### Create a new user

```sh
curl -XPOST -H "Content-Type: application/json" -d '{ "user": { "email": "test@example.com", "password": "12345678" } }' http://localhost:3001/users
```

#### Sign In

This will return a user JWT token for authentication on the GraphQL API.

```sh
curl -XPOST -i -H "Content-Type: application/json" -d '{ "user": { "email": "newx@example.com", "password": "123456" } }' http://localhost:3001/users/sign_in
```

Example response:

```json
{"success":true,"message":"Authentication successful.","jwt":"eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIxIiwic2NwIjoidXNlciIsImF1ZCI6bnVsbCwiaWF0IjoxNjMzOTc3MDcxLCJleHAiOjE2MzM5ODA2NzEsImp0aSI6IjkyNDU4M2JmLTliYzAtNDA3Zi1iYjkzLTYyZDdlYjQ1NzMyMiJ9.IyZoLIzggTYQnyZO14CRxUEBHq5m6LmWN2-TG3essy8"}
```

#### Access user data via JWT authentication

```sh
curl -XGET -H "Authorization: Bearer eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIxIiwic2NwIjoidXNlciIsImF1ZCI6bnVsbCwiaWF0IjoxNjMzOTc3MDcxLCJleHAiOjE2MzM5ODA2NzEsImp0aSI6IjkyNDU4M2JmLTliYzAtNDA3Zi1iYjkzLTYyZDdlYjQ1NzMyMiJ9.IyZoLIzggTYQnyZO14CRxUEBHq5m6LmWN2-TG3essy8" -H "Content-Type: application/json" http://localhost:3001/member-data
```

#### Sign Out

```sh
curl -XDELETE -H "Authorization: Bearer eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIxIiwic2NwIjoidXNlciIsImF1ZCI6bnVsbCwiaWF0IjoxNjMzOTc3MDcxLCJleHAiOjE2MzM5ODA2NzEsImp0aSI6IjkyNDU4M2JmLTliYzAtNDA3Zi1iYjkzLTYyZDdlYjQ1NzMyMiJ9.IyZoLIzggTYQnyZO14CRxUEBHq5m6LmWN2-TG3essy8" -H "Content-Type: application/json" http://localhost:3001/users/sign_out
```

## GrahpQL API

### GraphiQL console

- [GraphiQL console url](http://localhost:3001/graphiql)
- [GraphQL API docs](http://localhost:3001/docs)

