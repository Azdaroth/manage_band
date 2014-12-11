class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.integer :list_id, null: false, foreign_key: { references: :task_lists }
      t.text :name, null: false
      t.integer :position, null: false, default: 0

      t.timestamps
    end
    add_index :tasks, :list_id
  end
end
