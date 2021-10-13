module Types
  class MutationType < Types::BaseObject
    field :reveal, mutation: Mutations::Reveal, null: true
    field :new_game, mutation: Mutations::NewGame, null: true
    field :add_flag, mutation: Mutations::AddFlag, null: true
    field :remove_flag, mutation: Mutations::RemoveFlag, null: true
    field :save_game, mutation: Mutations::SaveGame, null: true
    field :resume_game, mutation: Mutations::ResumeGame, null: true
  end
end
