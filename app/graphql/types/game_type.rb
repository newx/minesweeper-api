module Types
  class GameType < Types::BaseObject
    field :board, Types::BoardType, null: false
    field :id, ID, null: false
    field :user_id, Integer, null: true
    field :user, Types::UserType, null: true
    field :rows, Integer, null: true
    field :cols, Integer, null: true
    field :mines, Integer, null: true
    field :status, Types::GameStatusType, null: true
    field :time_elapsed_secs, Integer, null: true
    field :board_state, GraphQL::Types::JSON, null: true
    field :won, Boolean, null: true
    field :winned_at, GraphQL::Types::ISO8601DateTime, null: true
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false

    def won
      object.status == "win"
    end
  end
end
