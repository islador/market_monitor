class Renameapivalidcolumn < ActiveRecord::Migration
  def up
  	rename_column :apis, :valid, :active
  end

  def down
  end
end
