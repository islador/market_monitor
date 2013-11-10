class ChangeTypeonapiswalletId < ActiveRecord::Migration
  def up
  	change_column :apis, :wallet_id, :string
  end

  def down
  	change_column :apis, :wallet_id, :int
  end
end
