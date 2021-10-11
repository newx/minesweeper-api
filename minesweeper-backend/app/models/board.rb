class Board
  attr_accessor :width, :height, :mines, :mines_count

  # class CellDoesNotExistError < StandardError; end

  DEFAULT_WIDTH = 10
  DEFAULT_HEIGHT = 10
  DEFAULT_MINES_COUNT = 10

  def initialize(width: DEFAULT_WIDTH, height: DEFAULT_HEIGHT, mines_count: DEFAULT_MINES_COUNT)
    @width  = width
    @height = height
    @mines_count = mines_count
    @mines = []

    setup!
  end

  def setup!
    create_grid
    create_mines
    calculate_neighbor_mines
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

  # Public: returns the board grid as an 2D array with each cell rendered value
  # as a string.
  def to_a(force_reveal: false)
    grid_rendered = Array.new(width) { Array.new(height) }

    grid.each do |row|
      row.each do |cell|
        grid_rendered[cell.row][cell.col] = cell.to_s(force_reveal: force_reveal)
      end
    end

    grid_rendered
  end

  # Public: Reveals a given cell.
  def reveal(row, col)
    cell = at(row, col)
    cell.reveal!
  rescue Errors::MineFoundError
    raise Errors::GameOver, "Game over!"
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
    row.between?(0, width - 1) && col.between?(0, height - 1)
  end

  # Public: Set grid mines at specific coordinates and recalculate neighbor mines.
  def create_fixed_mines(coordinates)
    coordinates.each do |coordinate|
      cell = at(*coordinate)
      cell.mine = true
      @mines << cell
    end

    calculate_neighbor_mines
  end

  def reset_mines!
    mines_positions.each do |coordinates|
      cell = at(*coordinates)
      cell.mine = false
    end

    @mines = []
  end

  # Public: Flags all mines on the grid.
  def flag_all_mines!
    mines.each(&:flag!)
  end

  private

  # Private: Creates a grid of cells.
  def create_grid
    0.upto(width - 1) do |row_index|
      0.upto(height - 1) do |column_index|
        grid[row_index][column_index] =
          Cell.new(board: self, row: row_index, col: column_index)
      end
    end
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

  # Private: Returns the mines positions on the grid.
  def mines_positions
    mines.map { |cell| [cell.row, cell.col] }
  end

  # Private: Sets the neighbor mines count for each cell.
  def calculate_neighbor_mines
    grid.each do |row|
      row.each(&:set_neighbors_count!)
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
end
