class CreateAssetAttachments < ActiveRecord::Migration
  def change
    create_table :asset_attachments do |t|
      t.integer :asset_id
      t.string :file, null: false
      t.integer :band_id, null: false

      t.timestamps
    end
    add_index :asset_attachments, :asset_id
    add_index :asset_attachments, :band_id
  end
end
