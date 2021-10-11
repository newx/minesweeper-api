module Types
  class GameType < Types::BaseObject
    field :id, ID, null: false
    field :user_id, Integer, null: true
    field :rows, Integer, null: true
    field :cols, Integer, null: true
    field :mines, Integer, null: true
    field :time_elapsed, Integer, null: true
    field :board_state, Types::JsonType, null: true
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
