# TODO

- [TODO](#todo)
  - [General](#general)
  - [Board](#board)
  - [Cell](#cell)
  - [Game](#game)
  - [Authentication API](#authentication-api)
  - [GraphQL API](#graphql-api)
    - [Graphql Mutations](#graphql-mutations)
    - [Graphql Queries](#graphql-queries)
    - [Graphql Types](#graphql-types)
## General

- [x] read about Minesweeper game and its rules
- [x] create initial spec doc
- [x] install and setup a Rails api (`rails new minesweeper-backend --api -d postgresql`)
- [x] setup Rspec
- [x] setup rubocop
- [x] create User model

## Board

  - [x] create a random number of mines at random positions
  - [x] print board to console for testing
## Cell
  - [x] find each cell neighbor mines
  - [x] flag a cell with a question mark
  - [x] check if flagged cells matches all mines
  - [x] when you reveal a cell having 0 neighbors_count, then all neighbors with 0 neighbors_count are revealed
## Game

  - [x] create Game model (with persistence)
  - [x] Ability to select the game parameters: number of rows, columns, and mines
  - [ ] Detect when game is over
  - [x] Detect if the game was won
  - [x] Ability to start a new game and preserve/resume the old ones
  - [x] serialize board state data
  - [ ] Time tracking
  - [ ] Ability to support multiple users/accounts

## Authentication API

- [x] install and setup devise
- [x] setup devise authentication via JWT
- [x] user sign up endpoint
- [x] user sign in endpoint to get JWT token
- [x] user sign out endpoint
- [x] sessions_controller spec
- [x] registrations_controller spec

## GraphQL API

- [x] install and setup graphql-ruby gem
- [x] install goldiloader gem to eager load ActiveRecord queries and avoid N + 1 queries

### Graphql Mutations

- [ ] game - start a new game
- [ ] game - save game
- [ ] game - resume game
- [ ] board - reveal cell
- [ ] board - flag a cell


### Graphql Queries

- [x] get game info
  - [x] includes board
- [x] get games list

### Graphql Types

- [x] GameType
- [x] BoardType
- [x] CellType
- [x] UserType
- [x] GridType
- [x] RowType
- [x] CellType