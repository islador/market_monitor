class AddColumnsToCorporations < ActiveRecord::Migration
  def up
  	add_column :corporations, :wallet_zero, :string
  	add_column :corporations, :wallet_one, :string
  	add_column :corporations, :wallet_two, :string
  	add_column :corporations, :wallet_three, :string
  	add_column :corporations, :wallet_four, :string
  	add_column :corporations, :wallet_five, :string
  	add_column :corporations, :wallet_six, :string
  end

  def down
  	remove_column :corporations, :wallet_zero, :string
  	remove_column :corporations, :wallet_one, :string
  	remove_column :corporations, :wallet_two, :string
  	remove_column :corporations, :wallet_three, :string
  	remove_column :corporations, :wallet_four, :string
  	remove_column :corporations, :wallet_five, :string
  	remove_column :corporations, :wallet_six, :string
  end
end
