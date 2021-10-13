# frozen_string_literal: true

class Mutations::NewGame < Mutations::BaseMutation
  description "Creates a new game"

  field :game, Types::GameType, "The new game created", null: true

  argument :level, Types::GameLevelsType, "Game Level", required: true

  def resolve(level:)
    game = Game.create!(
      user: current_user,
      level: level
    )

    { game: game }
  end
end
