class Renameapitypecolumn < ActiveRecord::Migration
  def up
  	rename_column :apis, :type, :entity
  end

  def down
  end
end
