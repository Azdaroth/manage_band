class Task < ActiveRecord::Base

  scope :by_position, -> { order(position: :asc) }

	belongs_to :list, class_name: "TaskList"

end
