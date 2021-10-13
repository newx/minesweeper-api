module Types
  class CellType < Types::BaseObject
    field :board, Types::BoardType, null: false
    field :row, Integer, null: true
    field :col, Integer, null: true
    field :mine, Boolean, null: true
    field :revealed, Boolean, null: true
    field :flagged, Boolean, null: true
    field :neighbors_count, Integer, null: true
  end
end
