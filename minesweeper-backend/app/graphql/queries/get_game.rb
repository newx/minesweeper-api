module Queries
  class GetGame < Queries::BaseQuery
    type Types::GameType, null: false

    argument :game_id, ID, required: true

    def resolve(game_id:)
      Game.by_user(current_user).find(game_id)
    end
  end
end