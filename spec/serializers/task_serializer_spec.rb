require 'rails_helper'

describe TaskSerializer do

	let(:task) { build_stubbed(:task, name: "task", position: 10) }

	subject { TaskSerializer.new(task) }

	it "returns valid json" do
		result = {
			"task" => {
				"name" => "task",
				"position" => 10,
				"id" => task.id,
				"list_id" => nil
			}
		}
		expect(result).to eq JSON.parse(subject.to_json)
	end

end