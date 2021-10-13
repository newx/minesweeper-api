# frozen_string_literal: true

class Mutations::ResumeGame < Mutations::BaseMutation
  description "Resumes a game"

  field :game, Types::GameType, "The resumed game", null: true

  argument :game_id, ID, required: true

  def resolve(game_id:)
    game = Game.by_user(current_user).find(game_id)

    game.started!

    { game: game }
  end
end
