class CreateAssets < ActiveRecord::Migration
  def change
    create_table :assets do |t|
      t.string :file, null: false
      t.string :name, null: false
      t.integer :band_id, null: false
      t.integer :asset_id

      t.timestamps
    end
    add_index :assets, :band_id
    add_index :assets, :asset_id
  end
end
