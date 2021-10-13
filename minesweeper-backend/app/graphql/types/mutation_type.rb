module Types
  class MutationType < Types::BaseObject
    field :reveal, mutation: Mutations::Reveal, null: true
    field :new_game, mutation: Mutations::NewGame, null: true
    field :add_flag, mutation: Mutations::AddFlag, null: true
    field :save_game, mutation: Mutations::SaveGame, null: true
  end
end
