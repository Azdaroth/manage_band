class RemoveBandIdFromAssets < ActiveRecord::Migration
  def change
    remove_column :assets, :band_id
  end
end
