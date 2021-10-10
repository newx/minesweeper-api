# Minesweeper Game

- [Minesweeper game](https://en.wikipedia.org/wiki/Minesweeper_(video_game))

- [Minesweeper Game](#minesweeper-game)
  - [Components](#components)
    - [Cell](#cell)
    - [Board](#board)
    - [Game](#game)
      - [Game levels](#game-levels)


## Components

### Cell

**Attributes**

- mine: (Boolean) whether the cell has a mine.
- position x
- position y
- revealed: Boolean
- flagged: Ability to 'flag' a cell with a question mark or red flag
- content: integer, nil, or mine

**Methods**

- reveal:
  * shows the number of adjacent mines if any.
  * if it has no adjacent mines, it recursively clear all adjacent cells with no mines.
- count_adjacent_mines:
  * iterate through each adjacent cell and returns the number of mines around it.
  * does not count itself.
- find adjacent cells with no mines:
  * If you click on a cell having no adjacent mines (in any of the surrounding eight cells) then all the adjacent cells are automatically cleared, thus saving our time.
  * Flood fill algorithm.

### Board

- A grid (2D array) of cells.

**Properties**

- grid
- width
- height
- size: defines the size of the grid (e.g. 20x20 cells)

**Methods**

- setup: fills each cell with: a mine or the number of adjacent mines. Blank/nil if it has 0 adjacent mines.
- count mines: returns the number of mines on the board.

### Game

Holds individual game properties.

- score
- level: defines game's dificulty. We can use randomness to fill each cell with mine
- time
- clicks

**Methods**

- start
- detect when the game is over (e.g. when you click on a mine, all cells are revealed)
- serialize the game state so it can be saved
- save game
- resume game
- Ability to select the game parameters: number of rows, columns, and mines
- support multiple users/accounts


#### Game levels

- Beginner – 9 * 9 Board and 10 Mines
- Intermediate – 16 * 16 Board and 40 Mines
- Advanced – 24 * 24 Board and 99 Mines
