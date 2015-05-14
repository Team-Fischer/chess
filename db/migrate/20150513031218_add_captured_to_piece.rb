class AddCapturedToPiece < ActiveRecord::Migration
  def change
    add_column :pieces, :captured, :boolean, default: false
  end
end
