class Board
  attr_accessor :width, :height, :mines, :mines_count

  DEFAULT_WIDTH = 10
  DEFAULT_HEIGHT = 10
  DEFAULT_MINES_COUNT = 10

  def initialize(width: DEFAULT_WIDTH, height: DEFAULT_HEIGHT, mines_count: DEFAULT_MINES_COUNT)
    @width  = width
    @height = height
    @mines_count = mines_count
    @mines = []
  end

  def setup!
    create_grid
    create_mines
    calculate_neighbor_mines
  end

  def new_board?
    revealed.empty? && flagged.empty?
  end

  def grid
    @grid ||= Array.new(width) { Array.new(height) }
  end

  # Public: Returns the count of mines that were correctly flagged.
  def correct_flags_count
    mines.count(&:flagged)
  end

  # Public: prints the board as a table of cells to console.
  def to_table(force_reveal: false)
    Terminal::Table.new do |t|
      grid.each_with_index do |row, row_index|
        t.add_row(row.map { |cell| cell.to_s(force_reveal: force_reveal) })
        t.add_separator unless last_grid_row?(row_index)
      end
    end
  end

  # Public: returns the board grid as an 2D array with each cell rendered or
  # or attributes values.
  def to_a(force_reveal: false, render: false)
    grid_copy = Array.new(width) { Array.new(height) }

    grid.each do |row|
      row.each do |cell|
        value = render ? cell.to_s(force_reveal: force_reveal) : cell.to_h
        grid_copy[cell.row][cell.col] = value
      end
    end

    grid_copy
  end

  # Public: flags a given cell.
  def flag(row, col)
    cell = at(row, col)
    cell.flag!
  end

  # Public: Reveals a given cell.
  def reveal(row, col)
    cell = at(row, col)
    cell.reveal!
  rescue Errors::MineFoundError
    raise Errors::GameOver, "Cell #{row}, #{col} has a mine. Game over!"
  end

  # Public: Returns a Cell at the given coordinates.
  def at(row, col)
    raise Errors::CellDoesNotExistError unless cell_exists?(row, col)

    grid[row][col]
  end

  # Public: Returns a grid cell at the given coordinates.
  def [](row, col)
    raise Errors::CellDoesNotExistError unless cell_exists?(row, col)

    grid[row][col]
  end

  # Public: Returns whether a cell exists or is valid at the given coordinates.
  def cell_exists?(row, col)
    return false if row.nil? || col.nil?

    row.between?(0, width - 1) && col.between?(0, height - 1)
  end

  # Public: Set grid mines at specific coordinates and recalculate neighbor mines.
  def create_fixed_mines!(coordinates)
    reset_mines!
    coordinates.each do |coordinate|
      cell = at(*coordinate)
      cell.mine = true
      @mines << cell
    end

    calculate_neighbor_mines
  end

  # Public: Loads board from board state data.
  def load_state!(board_state)
    reset_mines!
    create_grid

    board_state.each do |row|
      row.each do |cell_state|
        cell_state.symbolize_keys!
        cell = at(cell_state[:row], cell_state[:col])
        cell.load_state(cell_state)

        @mines << cell if cell.mine?
      end
    end
  end

  # Public: Unset all cells mines and @mines.
  def reset_mines!
    mines_coordinates.each do |coordinates|
      cell = at(*coordinates)
      cell.mine = false
    end

    @mines = []
  end

  # Public: Flags all mines on the grid.
  def flag_all_mines!
    mines.each(&:flag!)
  end

  # Public: Returns the mines coordinates on the grid.
  def mines_coordinates
    coordinates_for(mines)
  end

  # Public: Returns flagged cells as an array.
  def flagged
    grid.flatten.select(&:flagged?)
  end

  # Public: Returns the flagged coordinates on the grid.
  def flagged_coordinates
    coordinates_for(flagged)
  end

  def revealed
    grid.flatten.select(&:revealed?)
  end

  # Public: Returns the flagged coordinates on the grid.
  def revealed_coordinates
    coordinates_for(revealed)
  end

  private

  # Private: Creates a grid of cells.
  def create_grid
    reset_grid!

    0.upto(width - 1) do |row_index|
      0.upto(height - 1) do |column_index|
        grid[row_index][column_index] =
          Cell.new(board: self, row: row_index, col: column_index)
      end
    end
  end

  def reset_grid!
    @grid = nil
  end

  # Private: Creates random mines on the grid. Up to the mines_count limit.
  def create_mines
    while mines_count > mines.size
      cell = random_cell
      redo if @mines.include?(cell)

      cell.mine = true

      @mines << cell
    end
  end

  # Private: Sets the neighbor mines count for each cell.
  def calculate_neighbor_mines
    grid.each do |row|
      row.each do |cell|
        cell.update_neighbors_count!
      end
    end
  end

  # Private: Returns a random cell from the grid.
  def random_cell
    grid.sample.sample
  end

  # Private: Returns true if the given ro w index is the last row of the grid.
  def last_grid_row?(row_index)
    row_index == grid.length - 1
  end

  # Private: Returns the coordinates for the given cells.
  def coordinates_for(cells)
    cells.map { |cell| [cell.row, cell.col] }.sort
  end
end
