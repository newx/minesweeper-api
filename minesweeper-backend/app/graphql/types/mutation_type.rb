module Types
  class MutationType < Types::BaseObject
    field :reveal, mutation: Mutations::Reveal, null: true
    field :new_game, mutation: Mutations::NewGame, null: true
  end
end
