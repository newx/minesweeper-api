module Types
  class RowType < Types::BaseObject
    field :cells, [Types::CellType], null: true

    def cells
      object.to_a
    end
  end
end
