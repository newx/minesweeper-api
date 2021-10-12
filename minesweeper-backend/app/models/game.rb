class Game < ApplicationRecord
  belongs_to :user
  before_update :save_board_state

  # Public: Returns a board instance.
  def board
    @board ||= init_board
  end

  # Public: Whether the game was won.
  def won?
    board.correct_flags_count == board.mines_count
  end

  def self.by_user(user)
    where(user: user)
  end

  private

  # Private: Saves the board state.
  def save_board_state
    self.mines_positions = board.mines_positions
    self.rows = board.rows
    self.columns = board.columns
  end

  private

  # Private: Initialize a new board or load an existing one via game.board_state data.
  def init_board
    @board =
      if board_state.present?
        Board.new(width: rows, height: cols, mines_count: mines).tap do |b|
          b.load_board_state(board_state)
        end
      else
        Board.new(width: rows, height: cols, mines_count: mines).tap do |b|
          b.setup!
        end
      end
  end

  # Private: Save the board state.
  def save_board_state
    self.board_state = board.to_a(render: false)
  end
end
