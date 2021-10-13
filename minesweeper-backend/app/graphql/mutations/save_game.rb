# frozen_string_literal: true

class Mutations::SaveGame < Mutations::BaseMutation
  description "Saves a game"

  field :game, Types::GameType, "The saved game", null: true

  argument :game_id, ID, required: true

  def resolve(game_id:)
    game = Game.by_user(current_user).find(game_id)

    game.paused!

    { game: game }
  end
end
