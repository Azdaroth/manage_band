class CreateBandUsers < ActiveRecord::Migration
  def change
    create_table :band_users do |t|
      t.integer :band_id, null: false
      t.integer :user_id, null: false

      t.timestamps
    end
  end
end
