class CreateApis < ActiveRecord::Migration
  def change
    create_table :apis do |t|
      t.integer :user_id
      t.integer :type
      t.string :key_id
      t.string :v_code
      t.integer :accessmask
      t.integer :valid

      t.timestamps
    end
    add_index :apis, [:user_id, :valid]
  end
end
