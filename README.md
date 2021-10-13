# Minesweeper GraphQL API

- [Minesweeper GraphQL API](#minesweeper-graphql-api)
  - [Install and Setup](#install-and-setup)
  - [Tools used](#tools-used)
    - [rails 6.1](#rails-61)
    - [graphql-ruby](#graphql-ruby)
    - [graphql-docs](#graphql-docs)
    - [goldiloader](#goldiloader)
    - [terminal-table](#terminal-table)
    - [devise](#devise)
    - [devise-jwt](#devise-jwt)
  - [Environments](#environments)
    - [Local](#local)
    - [Heroku](#heroku)
  - [REST API](#rest-api)
    - [Users](#users)
      - [Create a new user](#create-a-new-user)
      - [Sign In](#sign-in)
      - [Access user data via JWT authentication](#access-user-data-via-jwt-authentication)
      - [Sign Out](#sign-out)
  - [GrahpQL API](#grahpql-api)
    - [Queries](#queries)
      - [GetGames query](#getgames-query)
      - [GetGame info](#getgame-info)
    - [Mutations](#mutations)
      - [New Game](#new-game)
      - [Reveal a board cell](#reveal-a-board-cell)
      - [Flag a board cell](#flag-a-board-cell)
      - [Remove a flag](#remove-a-flag)
      - [Save game](#save-game)
      - [Resume game](#resume-game)

## Install and Setup

1. Clone this repo

```sh
git@github.com:newx/minesweeper-api.git
```

2. Install ruby 2.7.0
3. Run bundle install

```sh
cd minesweeper-api
bundle install
```

4. Update database configuration on `config/database.yml`
5. Create databases

```sh
rails db:create
```

6. Run migrations

```sh
rails db:migrate
```

7. Run db seeds

```sh
rails db:seed
```

8. Start rails server

```sh
bundle exec rails server -p 3001
```

9. Get a user JWT token. See [Sign In](#sign-in) REST API endpoint.
10. Copy JWT token from the above request response
11. Export JWT token to your local environment.


```sh
export TOKEN="your token here"
```

Done. You can now make requests to the GraphQL server. See [GrahpQL API](#grahpql-api)

## Tools used

### rails 6.1

Rails is a web-application framework. See [link](https://github.com/rails/rails)

### graphql-ruby

A Ruby implementation of GraphQL.

### graphql-docs

Generates GraphQL docs based on GraphQL queries, mutations and types.

### goldiloader

goldiloader gem eager loads ActiveRecord queries and help avoid N + 1 queries.

### terminal-table

Tool used to print tables to Terminal console.

### devise

Devise is a flexible authentication solution for Rails based on Warden.
Devise helps us to boostrap a user authentication feature quickly and securely.

### devise-jwt

devise-jwt is a devise extension which uses JWT tokens for user authentication. It follows secure by default principle.
## Environments

### Local

- **App URL**: http://localhost:3001
- **GraphiQL console url**: http://localhost:3001/graphiql
- **GraphQL API docs**: http://localhost:3001/docs

### Heroku

- **Heroku app URL**: https://radiant-castle-13560.herokuapp.com/
- **GraphiQL console url**: https://radiant-castle-13560.herokuapp.com/graphiql
- **GraphQL API docs**: https://radiant-castle-13560.herokuapp.com/docs
  
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

Before making requests to the GraphQL API, you will need the following:

1. Get a user JWT token by making a request to the user sign-in endpoint [Sign In](#sign-in).
2. Copy the JWT token from the API response.
3. Export the JWT token to your local environment. See below:

```sh
export TOKEN=eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIyIiwic2NwIjoidXNlciIsImF1ZCI6bnVsbCwiaWF0IjoxNjM0MTYyNjM4LCJleHAiOjE2MzQxNjYyMzgsImp0aSI6ImU0ZTM1YmU3LWZkZTgtNGFlMC04ZTUzLTAxNTdlMTIxNzYwOSJ9.H5T-cbh91BEmLVJ9NdbxTR2WUkqmXpfKkFP5mDwquCk
```

4. Export API_URL to your local environment. See below:

**For Heroku env**

```sh
export API_URL=https://radiant-castle-13560.herokuapp.com/graphql
```

**For local env**

```sh
export API_URL=http://localhost:3001/graphql
```

### Queries

#### GetGames query

```sh
curl "${API_URL}" \
  -X POST \
  -H "content-type: application/json" \
  -H "Authorization: Bearer ${TOKEN}" \
  --data '{
    "query": "query { getGames { id rows cols status won } }"
  }'
```

Response:

```json
{"data":{"getGames":[{"id":"3","rows":10,"cols":10,"status":"started","won":false},{"id":"2","rows":10,"cols":10,"status":"started","won":false}]}}
```

#### GetGame info

```sh
curl "${API_URL}" \
  -X POST \
  -H "content-type: application/json" \
  -H "Authorization: Bearer ${TOKEN}" \
  --data '{
    "variables": { "gameId": 3 },
    "query": "query ($gameId: ID!) { getGame(gameId: $gameId) { id rows cols status won board { width height minesCount grid { rows { cells { row col mine revealed flagged neighborsCount } } } } } }"
  }'
```

Response:

```json
{"data":{"getGame":{"id":"3","rows":10,"cols":10,"status":"started","won":false,"board":{"width":10,"height":10,"minesCount":10,"grid":{"rows":[{"cells":[{"row":0,"col":0,"mine":false,"revealed":false,"flagged":false,"neighborsCount":1},{"row":0,"col":1,"mine":false,"revealed":false,"flagged":false,"neighborsCount":2},{"row":0,"col":2,"mine":false,"revealed":false,"flagged":false,"neighborsCount":1},{"row":0,"col":3,"mine":false,"revealed":false,"flagged":false,"neighborsCount":1} ...
```

### Mutations
#### New Game

```sh
curl "${API_URL}" \
  -X POST \
  -H "content-type: application/json" \
  -H "Authorization: Bearer ${TOKEN}" \
  --data '{
    "variables": { "input": { "level": "beginner" } },
    "query": "mutation ($input: NewGameInput!) { newGame(input: $input) { game { id rows cols status won board { width height minesCount grid { rows { cells { row col mine revealed flagged neighborsCount } } } } } } }"
  }'
```

Response:

```json
{"data":{"newGame":{"game":{"id":"4","rows":10,"cols":10,"status":"started","won":false,"board":{"width":10,"height":10,"minesCount":10,"grid":{"rows":[{"cells":[{"row":0,"col":0,"mine":false,"revealed":false,"flagged":false,"neighborsCount":0},{"row":0,"col":1,"mine":false,"revealed":false,"flagged":false,"neighborsCount":0},{"row":0,"col":2,"mine":false,"revealed":false,"flagged":false,"neighborsCount":0},{"row":0,"col":3,"mine":false,"revealed":false,"flagged":false,"neighborsCount":0},{"row":0,"col":4,"mine":false,"revealed":false,"flagged":false,"neighborsCount":0},{"row":0,"col":5,"mine":false,"revealed":false,"flagged":false,"neighborsCount":0}...
```

#### Reveal a board cell

```sh
curl "${API_URL}" \
  -X POST \
  -H "content-type: application/json" \
  -H "Authorization: Bearer ${TOKEN}" \
  --data '{
    "variables": { "input": { "gameId": 3, "row": 9, "col": 9 } },
    "query": "mutation ($input: RevealInput!) { reveal(input: $input) { revealedCells { row col neighborsCount } win } }"
  }'
```

Response:

```json
{"data":{"reveal":{"revealedCells":[{"row":9,"col":9,"neighborsCount":0},{"row":8,"col":9,"neighborsCount":0},{"row":7,"col":8,"neighborsCount":0},{"row":6,"col":7,"neighborsCount":0},{"row":5,"col":6,"neighborsCount":0},{"row":4,"col":5,"neighborsCount":0},{"row":3,"col":5,"neighborsCount":0},{"row":2,"col":5,"neighborsCount":0},{"row":1,"col":5,"neighborsCount":0},{"row":0,"col":5,"neighborsCount":0},{"row":4,"col":6,"neighborsCount":0},{"row":4,"col":7,"neighborsCount":0},{"row":5,"col":7,"neighborsCount":0},{"row":6,"col":6,"neighborsCount":0},{"row":5,"col":5,"neighborsCount":0},{"row":5,"col":4,"neighborsCount":0},{"row":5,"col":3,"neighborsCount":0},{"row":5,"col":2,"neighborsCount":0},{"row":4,"col":1,"neighborsCount":0},{"row":3,"col":0,"neighborsCount":0},{"row":2,"col":0,"neighborsCount":0},{"row":1,"col":0,"neighborsCount":0},{"row":0,"col":0,"neighborsCount":0},{"row":0,"col":1,"neighborsCount":0},{"row":1,"col":1,"neighborsCount":0},{"row":2,"col":1,"neighborsCount":0},{"row":3,"col":1,"neighborsCount":0},{"row":4,"col":0,"neighborsCount":0},{"row":5,"col":0,"neighborsCount":0},{"row":5,"col":1,"neighborsCount":0},{"row":6,"col":3,"neighborsCount":0},{"row":6,"col":4,"neighborsCount":0},{"row":6,"col":5,"neighborsCount":0},{"row":7,"col":4,"neighborsCount":0},{"row":7,"col":5,"neighborsCount":0},{"row":7,"col":6,"neighborsCount":0},{"row":7,"col":7,"neighborsCount":0},{"row":8,"col":5,"neighborsCount":0},{"row":8,"col":4,"neighborsCount":0},{"row":9,"col":4,"neighborsCount":0},{"row":9,"col":5,"neighborsCount":0},{"row":7,"col":9,"neighborsCount":0}],"win":false}}}
```

#### Flag a board cell

```sh
curl "${API_URL}" \
  -X POST \
  -H "content-type: application/json" \
  -H "Authorization: Bearer ${TOKEN}" \
  --data '{
    "variables": { "input": { "gameId": 3, "row": 9, "col": 9 } },
    "query": "mutation ($input: AddFlagInput!) { addFlag(input: $input) { cell { row col neighborsCount } } }"
  }'
```

Response:

```json
{"data":{"addFlag":{"cell":{"row":9,"col":9,"neighborsCount":0}}}}
```

#### Remove a flag

```sh
curl "${API_URL}" \
  -X POST \
  -H "content-type: application/json" \
  -H "Authorization: Bearer ${TOKEN}" \
  --data '{
    "variables": { "input": { "gameId": 3, "row": 9, "col": 9 } },
    "query": "mutation ($input: RemoveFlagInput!) { removeFlag(input: $input) { cell { row col neighborsCount } } }"
  }'
```

Response:

```json
{"data":{"removeFlag":{"cell":{"row":9,"col":9,"neighborsCount":0}}}}
```

#### Save game

```sh
curl "${API_URL}" \
  -X POST \
  -H "content-type: application/json" \
  -H "Authorization: Bearer ${TOKEN}" \
  --data '{
    "variables": { "input": { "gameId": 3 } },
    "query": "mutation ($input: SaveGameInput!) { saveGame(input: $input) { game { id status } } }"
  }'
```

Response:

```json
{"data":{"saveGame":{"game":{"id":"3","status":"paused"}}}}
```

#### Resume game

```sh
curl "${API_URL}" \
  -X POST \
  -H "content-type: application/json" \
  -H "Authorization: Bearer ${TOKEN}" \
  --data '{
    "variables": { "input": { "gameId": 3 } },
    "query": "mutation ($input: ResumeGameInput!) { resumeGame(input: $input) { game { id status } } }"
  }'
```

Response:

```json
{"data":{"resumeGame":{"game":{"id":"3","status":"started"}}}}
```
