class RemoveColumns < ActiveRecord::Migration
  def up
  	remove_column :users, :v_code
  	remove_column :users, :key_id
  end

  def down
  end
end
