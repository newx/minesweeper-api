class Cell
  attr_accessor :board, :row, :col, :revealed, :flagged, :mine, :neighbors_count

  NEIGHBOR_OFFSETS = [[-1, -1], [-1, 0], [-1, 1], [0, 1], [0, -1], [1, 1], [1, 0], [1, -1]].freeze

  def initialize(board:, row:, col:, mine: false, revealed: true)
    @board = board
    @row = row
    @col = col
    @revealed = revealed
    @mine = mine
    @neighbors_count = 0
  end

  alias mine? mine
  alias revealed? revealed

  # Public: Calculate and set neighbors count.
  def set_neighbors_count!
    @neighbors_count = neighbor_mines_count
  end

  # Public: Returns the number of mines in the neighbors cells.
  def neighbor_mines_count
    neighbor_cells.count(&:mine?) unless mine?
  end

  # Public: Returns the cell content.
  def to_s
    if revealed
      mine ? "x" : neighbors_count.to_s
    else
      flagged ? "F" : "*"
    end
  end

  def to_h
    {
      row: row,
      col: col,
      mine: mine,
      revealed: revealed,
      flagged: flagged,
      neighbors_count: neighbors_count
    }
  end

  private

  # Private: Returns all the neighbors cells.
  # Returns an array of Cell objects.
  def neighbor_cells
    @neighbor_cells ||= neighbor_cell_coordinates.map do |coordinates|
      board.at(coordinates[0], coordinates[1]) if board.cell_exists?(coordinates[0], coordinates[1])
    end.compact
  end

  # Public: Returns the coordinates of the neighboars cells.
  def neighbor_cell_coordinates
    NEIGHBOR_OFFSETS.map { |coordinates| [row + coordinates[0], col + coordinates[1]] }
  end
end
