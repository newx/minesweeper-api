class AddWinnedAtToGame < ActiveRecord::Migration[6.1]
  def change
    add_column :games, :winned_at, :datetime
  end
end
