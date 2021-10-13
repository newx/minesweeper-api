# frozen_string_literal: true

class Mutations::AddFlag < Mutations::BaseMutation
  description "Adds a flag to a board cell"

  field :cell, Types::CellType, "The flagged cell", null: true

  argument :game_id, ID, required: true
  argument :row, Integer, "Cell row coordinate", required: true
  argument :col, Integer, "Cell col coordinate", required: true

  def resolve(game_id:, row:, col:)
    game = Game.by_user(current_user).find(game_id)

    cell = game.board.at(row, col)

    game.play do |gm|
      gm.board.flag(row, col)
    end

    { cell: cell }
  rescue Errors::CellDoesNotExistError => e
    raise GraphQL::ExecutionError, e.message
  end
end
