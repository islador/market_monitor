class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :key_id
      t.string :v_code

      t.timestamps
    end
  end
end
