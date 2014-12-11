class TaskListSerializer < ActiveModel::Serializer

	attributes :name

	has_many :tasks

end