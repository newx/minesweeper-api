# TODO

- [TODO](#todo)
  - [General](#general)
  - [Bonus](#bonus)
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
- [x] install/setup graphql-doc and generate GraphQL doc
- [ ] update README
  - [ ] add docs about each component

## Bonus

- [ ] deploy backend to Heroku
- [ ] api client on a different language (JS maybe?)
- [ ] update game status to idle when it's idle for x minutes (via sidekiq worker)
- [ ] Frontend in ReactJS or Angular

## Board

  - [x] create a random number of mines at random positions
  - [x] print board to console for testing
## Cell
  - [x] find each cell neighbor mines
  - [x] flag a cell with a question mark
  - [x] check if flagged cells matches all mines
  - [x] when you reveal a cell having 0 neighbors_count, then all neighbors with 0 neighbors_count are revealed
  - [ ] The first click in any game will never be a mine
## Game

  - [x] create Game model (with persistence)
  - [x] Ability to select the game parameters: number of rows, columns, and mines
  - [x] Detect when game is over
    - [x] set game status when game is over
  - [x] Detect if the game was won
    - [x] To win the game, players must uncover all non-mine cells, at which point, the timer is stopped
  - [x] Ability to start a new game and preserve/resume the old ones
  - [x] serialize board state data
  - [x] Time tracking
  - [x] Ability to support multiple users/accounts
  - [x] adds a method Game#play in which you can the board is changed and saved inside a yield block

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

- [x] game - start a new game
- [x] game - on every request (mutation) the game and board state is saved
- [x] board - reveal cell
- [x] game - save game
- [x] game - resume game
- [x] board - flag a cell
- [x] remove a flag


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
