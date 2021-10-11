class CreateGames < ActiveRecord::Migration[6.1]
  def change
    create_table :games do |t|
      t.integer :user_id
      t.integer :rows, default: Board::DEFAULT_WIDTH
      t.integer :cols, default: Board::DEFAULT_HEIGHT
      t.integer :mines, default: Board::DEFAULT_MINES_COUNT
      t.integer :time_elapsed, default: 0

      t.timestamps
    end
  end
end
