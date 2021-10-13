class Game < ApplicationRecord
  belongs_to :user

  attr_accessor :board

  after_initialize :init_board

  enum status: { started: 0, idle: 1, paused: 2, game_over: 3 }

  def self.by_user(user)
    where(user: user)
  end

  def save_board!
    update!(board_state: board.to_a)
  end

  # Public: Whether the game was won.
  # To win the game players must uncover all non-mine cells.
  def won?
    board.correct_flags_count == board.mines_count
  end

  # Public: Wraps a block of multiple actions and then saves the board state.
  # Returns the yielded block return value.
  #
  # Example:
  #   game.play do |gm|
  #     gm.board.reveal(0, 1)
  #     gm.board.flag(0, 5)
  #   end
  def play
    return_value = yield self

    save_board!

    return_value
  end

  # Private: Initialize a new board or load an existing one via game.board_state data.
  def init_board
    @board =
      if board_state.present?
        Board.new(width: rows, height: cols, mines_count: mines).tap do |b|
          b.load_state!(board_state)
        end
      else
        Board.new(width: rows, height: cols, mines_count: mines).tap do |b|
          b.setup!
        end
      end
  end
end
