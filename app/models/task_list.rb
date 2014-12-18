class TaskList < ActiveRecord::Base

	has_many :tasks, foreign_key: :list_id

  belongs_to :band

end
