class Game < ApplicationRecord
  def board
    @board ||= Board.new(width: rows, height: cols, mines_count: mines)
  end

  def won?
    board.correct_flags_count == board.mines_count
  end
end
