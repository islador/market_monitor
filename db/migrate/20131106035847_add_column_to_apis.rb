class AddColumnToApis < ActiveRecord::Migration
  def up
  	add_column :apis, :wallet_id, :int
  end

  def down
  	remove_column :apis, :wallet_id, :int
  end
end
