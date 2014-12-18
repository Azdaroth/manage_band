class TaskListSerializer < ActiveModel::Serializer

	attributes :name, :id, :tasks

  def tasks
    object.tasks_by_position.map { |task| TaskSerializer.new(task, root: false) }
  end

end