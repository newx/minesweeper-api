module Types
  class GridType < Types::BaseObject
    field :rows, [Types::RowType], null: true

    def rows
      object.to_a
    end
  end
end
