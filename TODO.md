# TODO

- [TODO](#todo)
  - [General](#general)
  - [Board](#board)
  - [Game](#game)
  - [GraphQL API](#graphql-api)
    - [Graphql Mutations](#graphql-mutations)
    - [Graphql Queries](#graphql-queries)
## General

- [x] read about Minesweeper game and its rules
- [x] create initial spec doc
- [x] install and setup a Rails api (`rails new minesweeper-backend --api -d postgresql`)
- [x] setup Rspec
- [x] setup rubocop

## Board

  - [x] create a random number of mines at random positions
  - [x] print board to console for testing
  - [ ] check if flagged cells matches all mines
- [ ] cell
  - [x] find each cell neighbor mines
  - [ ] flag a cell
  - [ ] when you reveal a cell having 0 neighbors_count, then all neighbors with 0 neighbors_count are revealed
## Game

  - [ ] create Game model (with persistence)
  - [ ] save game
  - [ ] resume game
  - [ ] accept game parameters
  - [ ] serialize game state data
  - [ ] game time elapsed

## GraphQL API

  - [ ] create User model
  - [ ] install and setup devise
  - [ ] install and setup graphql-ruby gem
  - [ ] setup devise authentication via JWT

### Graphql Mutations

### Graphql Queries