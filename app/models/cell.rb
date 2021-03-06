class Cell
  attr_accessor :board, :row, :col, :revealed, :flagged, :mine, :neighbors_count

  # Defines the offsets of the neighboars cells.
  NEIGHBOR_OFFSETS = [
    # Top neighbors
    [-1, -1], [-1, 0], [-1, 1],
    # Left and right neighbors
    [0, -1], [0, 1],
    # Bottom neighbors
    [1, -1], [1, 0], [1, 1]
  ].freeze

  def initialize(board:, row:, col:, mine: false, revealed: false)
    @board = board
    @row = row
    @col = col
    @revealed = revealed
    @mine = mine
    @flagged = false
    @neighbors_count = 0
  end

  alias mine? mine
  alias revealed? revealed
  alias flagged? flagged

  # Public: Calculate and set neighbors count.
  def update_neighbors_count!
    @neighbors_count = neighbor_mines_count
  end

  # Public: Returns the number of mines in the neighbors cells.
  def neighbor_mines_count
    neighbor_cells.count(&:mine?)
  end

  def neighbors_count_to_s
    neighbors_count.positive? ? neighbors_count.to_s : " "
  end

  # Public: Reveals the cell and recursively reveals the neighbors cells that
  # have neighbors_count equal zero.
  def reveal!
    raise Errors::CellAlreadyRevealedError, "(#{row}, #{col})" if revealed?

    @revealed = true

    raise Errors::MineFoundError, "Mine found error" if mine?

    revealed_cells = [self]

    neighbor_cells.each do |neighbor|
      if !neighbor.revealed? && neighbor.neighbors_count.zero? && !neighbor.mine?
        revealed_cells << neighbor.reveal!
      end
    end

    revealed_cells.uniq.flatten
  end

  def flag!
    @flagged = true
  end

  def unflag!
    @flagged = false
  end

  # Public: Returns the cell content.
  def to_s(force_reveal: false)
    if revealed || force_reveal
      if mine?
        "x"
      else
        neighbors_count_to_s
      end
    else
      flagged ? "?" : "*"
    end
  end

  # Public: Loads a cell from a hash.
  def load_state(state)
    state.symbolize_keys!

    @mine = state[:mine].present?
    @revealed = state[:revealed].present?
    @flagged = state[:flagged].present?
    @neighbors_count = state[:neighbors_count]
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

  def to_coordinates
    [row, col]
  end
  alias to_c to_coordinates

  private

  def no_neighbor_mines?
    neighbors_count.zero?
  end

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
