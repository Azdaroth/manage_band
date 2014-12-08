class CreateAssetLists < ActiveRecord::Migration
  def change
    create_table :asset_lists do |t|
      t.string :name, null: false
      t.integer :band_id, null: false

      t.timestamps
    end
    add_index :asset_lists, :band_id
  end
end
