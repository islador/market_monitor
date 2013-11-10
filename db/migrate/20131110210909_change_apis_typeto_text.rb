class ChangeApisTypetoText < ActiveRecord::Migration
  def up
  	change_column :apis, :wallet_id, :text
  end

  def down
  	change_column :apis, :wallet_id, :string
  end
end
