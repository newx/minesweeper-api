class Board
  attr_accessor :width, :height

  DEFAULT_WIDTH = 10
  DEFAULT_HEIGHT = 10

  def initialize(width: DEFAULT_WIDTH, height: DEFAULT_HEIGHT)
    @width  = width
    @height = height
  end

  # Public: prints the board to console.
  def show
    grid.each do |row|
      row.each do |cell|
        puts cell.to_s
      end
    end
  end

  private

  # Private: initializes the grid.
  def grid
    @grid ||= create_grid
  end

  # Creates a grid of cells.
  def create_grid
    # TODO: maybe we should initialize the cells already with randomly mines here.
    Array.new(width) { Array.new(height) { Cell.new } }
  end
end