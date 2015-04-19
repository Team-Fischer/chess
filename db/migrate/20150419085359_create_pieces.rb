class CreatePieces < ActiveRecord::Migration
  def change
    create_table :pieces do |t|
      t.integer :piece_id
      t.string :piece_name
      t.string :color

      t.timestamps
    end
  end
end
