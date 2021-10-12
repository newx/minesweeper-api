module Queries
  class GetGames < Queries::BaseQuery
    type [Types::GameType], null: false

    def resolve
      Game.by_user(current_user).order(created_at: :desc)
    end
  end
end