module Types
  class MutationType < Types::BaseObject
    field :reveal, mutation: Mutations::Reveal, null: true
  end
end
