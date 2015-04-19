class CreatePieces < ActiveRecord::Migration
  def change
    create_table :pieces do |t|
      t.integer :game_id
      t.string :piece_name
      t.string :color
      t.integer :x_coord
      t.integer :y_coord

      t.timestamps
    end
  end
end
