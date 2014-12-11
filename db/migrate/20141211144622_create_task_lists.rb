class CreateTaskLists < ActiveRecord::Migration
  def change
    create_table :task_lists do |t|
      t.string :name
      t.integer :band_id, null: false

      t.timestamps
    end
    add_index :task_lists, :band_id
  end
end
