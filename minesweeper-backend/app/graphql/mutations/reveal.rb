# frozen_string_literal: true

class Mutations::Reveal < Mutations::BaseMutation
  description "Reveals a board cell"

  field :cell, Types::CellType, "The revealed cell", null: true
  field :revealed_cells, [Types::CellType], "All revealed cells", null: true

  argument :game_id, ID, required: true
  argument :row, Integer, "Cell row coordinate", required: true
  argument :col, Integer, "Cell col coordinate", required: true

  def resolve(game_id:, row:, col:)
    game = Game.by_user(current_user).find(game_id)

    revealed_cells =
      game.play do |gm|
        gm.board.reveal(row, col)
      end

    cell = revealed_cells.first

    { cell: cell, revealed_cells: revealed_cells }
  rescue Errors::CellAlreadyRevealedError => e
    raise GraphQL::ExecutionError, e.message
  rescue Errors::GameOver
    game.game_over!
  end
end
