class AddListIdToAssets < ActiveRecord::Migration
  def change
    add_column :assets, :list_id, :integer, null: false, foreign_key: { references: AssetList }
    add_index :assets, :list_id
  end
end
