class AddColumntoApIs < ActiveRecord::Migration
  def up
  	add_column :apis, :corporation_id, :int
  end

  def down
  	remove_column :apis, :corporation_id, :int
  end
end
