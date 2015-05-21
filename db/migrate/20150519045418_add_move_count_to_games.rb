class AddMoveCountToGames < ActiveRecord::Migration
  def change
  	add_column :games, :move_count, :integer, :default => 0 
  end
end
