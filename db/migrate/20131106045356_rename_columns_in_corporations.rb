class RenameColumnsInCorporations < ActiveRecord::Migration
  def up
  	rename_column :corporations, :wallet_zero, :wallet_0
  	rename_column :corporations, :wallet_one, :wallet_1
  	rename_column :corporations, :wallet_two, :wallet_2
  	rename_column :corporations, :wallet_three, :wallet_3
  	rename_column :corporations, :wallet_four, :wallet_4
  	rename_column :corporations, :wallet_five, :wallet_5
  	rename_column :corporations, :wallet_six, :wallet_6
  end

  def down
  	rename_column :corporations, :wallet_0, :wallet_zero
  	rename_column :corporations, :wallet_1, :wallet_one
  	rename_column :corporations, :wallet_2, :wallet_two
  	rename_column :corporations, :wallet_3, :wallet_three
  	rename_column :corporations, :wallet_4, :wallet_four
  	rename_column :corporations, :wallet_5, :wallet_five
  	rename_column :corporations, :wallet_6, :wallet_six
  end
end
