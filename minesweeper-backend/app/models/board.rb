class Board
  attr_accessor :width, :height

  DEFAULT_WIDTH = 10
  DEFAULT_HEIGHT = 10

  def initialize(width: DEFAULT_WIDTH, height: DEFAULT_HEIGHT)
    @width  = width
    @height = height
  end

  # Public: prints the board as a table of cells to console.
  def to_table
    Terminal::Table.new do |t|
      grid.each_with_index do |row, row_index|
        t.add_row row.map(&:to_s)
        t.add_separator unless last_grid_row?(row_index)
      end
    end
  end

  # Private: initializes the grid.
  def grid
    @grid ||= create_grid
  end

  private

  # Creates a grid of cells.
  def create_grid
    # TODO: maybe we should initialize the cells already with randomly mines here.
    Array.new(width) { Array.new(height) { Cell.new } }
  end

  # Private: Returns true if the given row index is the last row of the grid.
  def last_grid_row?(row_index)
    row_index == grid.length - 1
  end
end