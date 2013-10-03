class CreateCacheTimes < ActiveRecord::Migration
  def change
    create_table :cache_times do |t|
      t.integer :user_id
      t.integer :api_id
      t.datetime :cached_time
      t.integer :call_type

      t.timestamps
    end
    add_index :cache_times, [:user_id, :api_id]
  end
end
