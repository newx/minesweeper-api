# Minesweeper Game

- [Minesweeper Game](#minesweeper-game)
  - [Components](#components)
    - [Cell](#cell)
    - [Board](#board)
    - [Game](#game)
      - [Game levels](#game-levels)


## Components

### Cell

**Attributes**

- state
- position x
- position y
- revealed: boolean
- flagged: Ability to 'flag' a cell with a question mark or red flag
- content: integer, nil, or bomb

**Methods**

- reveal:
  - shows the number of adjacent bombs if any
  - if it has no adjacent bombs, it recursively clear all adjacent cells with no mines.
- count_bombs
  - iterate through each adjacent/neighbor cell and returns the number of bombs around it
  - does not count itself
- find adjacent cells with no bombs:
  - If you click on a cell having no adjacent mines (in any of the surrounding eight cells) then all the adjacent cells are automatically cleared, thus saving our time.
  - Flood fill algorithm

### Board

- A grid (2D array) of cells.

**Properties**

- width
- height
- size: defines the size of the grid (e.g. 20x20 cells)
- cell_width

**Methods**

- setup: fills each cell with: a bomb or the number of adjacent bombs. Blank/nil if it has 0 adjacent bombs.
- print: for console testing

### Game

Holds individual game properties.

- score
- level: defines game's dificulty. We can use randomness to fill each cell with bomb
- time:
- clicks

**Methods**

- start
- detect when the game is over (e.g. when you click on a mine, all cells are revealed)
- save game
- resume game
- Ability to select the game parameters: number of rows, columns, and mines
- support multiple users/accounts

#### Game levels

- Beginner – 9 * 9 Board and 10 Mines
- Intermediate – 16 * 16 Board and 40 Mines
- Advanced – 24 * 24 Board and 99 Mines