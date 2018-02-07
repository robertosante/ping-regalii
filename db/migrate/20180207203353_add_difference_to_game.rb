class AddDifferenceToGame < ActiveRecord::Migration
  def change
    add_column :games, :difference, :integer
  end
end
