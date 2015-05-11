class AddTurnToGames < ActiveRecord::Migration
  def change
    add_column :games, :player_turn, :string
  end
end
