module Types
  class BoardType < Types::BaseObject
    field :width, Integer, null: true
    field :height, Integer, null: true
    field :mines_count, Integer, null: true
  end
end
