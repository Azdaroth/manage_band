class TaskList < ActiveRecord::Base

	has_many :tasks, foreign_key: :list_id

  belongs_to :band

  def tasks_by_position
    tasks.by_position
  end

end
