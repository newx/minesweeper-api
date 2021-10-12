module Queries
  class GetGames < Queries::BaseQuery

    type [Types::GameType], null: false

    def resolve
      Rails.logger.debug "USER: #{current_user.inspect}"
      games = Game.by_user(current_user).order(created_at: :desc)

      games
    end
  end
end