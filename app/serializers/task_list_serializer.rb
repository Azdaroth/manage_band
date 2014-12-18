class TaskListSerializer < ActiveModel::Serializer

	attributes :name, :id

	has_many :tasks

end