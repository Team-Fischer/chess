class AddFirebaseKeyToGame < ActiveRecord::Migration
  def change
    add_column :games, :firebase_key, :string
  end
end
