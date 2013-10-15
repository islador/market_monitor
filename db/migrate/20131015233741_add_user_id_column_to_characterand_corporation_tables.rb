class AddUserIdColumnToCharacterandCorporationTables < ActiveRecord::Migration
  def change
  	add_column :characters, :user_id, :integer
  	add_column :corporations, :user_id, :integer
  end
end
