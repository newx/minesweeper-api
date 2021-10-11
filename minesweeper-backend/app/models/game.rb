class Game < ApplicationRecord
  before_save :save_board_state

  def board
    @board ||= Board.new(width: rows, height: cols, mines_count: mines)
  end

  def won?
    board.correct_flags_count == board.mines_count
  end

  private

  def save_board_state
    self.board_state = board.to_a(render: false)
  end
end
