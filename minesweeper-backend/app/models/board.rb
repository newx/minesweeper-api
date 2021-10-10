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

    setup!
  end

  def setup!
    create_grid
    create_mines
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

  # Private: Creates a grid of cells.
  def create_grid
    Array.new(width) { Array.new(height) { Cell.new } }
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

  # Private: Returns a random cell from the grid.
  def random_cell
    grid.sample.sample
  end

  # Private: Returns true if the given row index is the last row of the grid.
  def last_grid_row?(row_index)
    row_index == grid.length - 1
  end
end