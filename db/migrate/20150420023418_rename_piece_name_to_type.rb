class RenamePieceNameToType < ActiveRecord::Migration

  def change
    rename_column :pieces, :piece_name, :type
  end

end
