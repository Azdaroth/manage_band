require 'rails_helper'

describe TaskListSerializer do

	let(:task_list) { build_stubbed(:task_list, name: "task_list") }
	let(:task) { build_stubbed(:task, name: "task") }

	before(:each) do
		allow(task_list).to receive(:tasks) { [task] }
	end

	subject { TaskListSerializer.new(task_list) }

	it "returns valid json" do
		result = {
			"task_list" => {
				"name" => "task_list",
				"tasks" => [
					{
						"name" => "task",
						"position" => 0
					}
				]
			}
		}
		expect(result).to eq JSON.parse(subject.to_json)
	end

end