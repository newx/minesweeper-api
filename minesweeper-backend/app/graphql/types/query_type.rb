module Types
  class QueryType < Types::BaseObject
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    field :get_games, resolver: Queries::GetGames, null: true
    field :get_game, resolver: Queries::GetGame, null: true
  end
end
