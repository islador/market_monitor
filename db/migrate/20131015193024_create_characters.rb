class CreateCharacters < ActiveRecord::Migration
  def change
    create_table :characters do |t|
      t.string :name
      t.integer :char_id

      t.timestamps
    end
  end
end
