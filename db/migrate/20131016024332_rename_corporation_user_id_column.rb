class RenameCorporationUserIdColumn < ActiveRecord::Migration
  def up
  	rename_column :corporations, :user_id, :character_id
  end

  def down
  	rename_column :corporations, :character_id, :user_id
  end
end
