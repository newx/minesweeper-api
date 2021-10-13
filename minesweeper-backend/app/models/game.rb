class Game < ApplicationRecord
  belongs_to :user

  attr_accessor :board

  after_initialize :init_board
  before_create :update_settings_based_on_game_level

  enum status: { started: 0, idle: 1, paused: 2, game_over: 3, win: 4 }
  enum level: { beginner: 0, intermediate: 1, expert: 2 }

  LEVELS = {
    beginner: { rows: 10, cols: 10, mines: 10 },
    intermediate: { rows: 16, cols: 16, mines: 40 },
    expert: { rows: 24, cols: 24, mines: 99 }
  }.freeze

  def self.by_user(user)
    where(user: user)
  end

  def save_board!
    update!(board_state: board.to_a)
  end

  # Public: Whether the game was won.
  # To win the game players must uncover all non-mine cells.
  def won?
    board.all_non_mines_cells_revealed?
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

  # Public: Returns the time elapsed since the game started and the last time it was
  # saved or the current time.
  # NOTE: This is a simple time elapsed calculation and is not accurate. A better
  # approach would take into account only the time a game is actually being played.
  def time_elapsed_secs
    ((winned_at || updated_at || Time.zone.now) - created_at).to_i.seconds
  end

  private

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

  def update_settings_based_on_game_level
    level_settings = LEVELS[level.to_sym]

    self.rows = level_settings[:rows]
    self.cols = level_settings[:cols]
    self.mines = level_settings[:mines]
  end
end
