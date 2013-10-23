class AddColumnsToStations < ActiveRecord::Migration
  def change
  	add_column :stations, :name, :string
  	add_column :stations, :station_id, :integer
  end
end
