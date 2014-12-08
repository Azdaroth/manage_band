class RemoveFileFromAssets < ActiveRecord::Migration
  def change
    remove_column :assets, :file
  end
end
