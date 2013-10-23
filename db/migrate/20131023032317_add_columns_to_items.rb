class AddColumnsToItems < ActiveRecord::Migration
  def change
  	add_column :items, :name, :string
  	add_column :items, :type_id, :integer
  	add_column :items, :volume, :float
  	add_column :items, :market_group_id, :integer
  end
end
