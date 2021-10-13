module Types
  class BoardType < Types::BaseObject
    field :width, Integer, null: true
    field :height, Integer, null: true
    field :mines_count, Integer, null: true
    field :grid, Types::GridType, null: true

    def gird
      object.grid
    end
  end
end
