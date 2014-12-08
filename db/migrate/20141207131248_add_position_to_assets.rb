class AddPositionToAssets < ActiveRecord::Migration
  def change
    add_column :assets, :position, :integer, null: false, default: 0
    add_index :assets, :position
  end
end
