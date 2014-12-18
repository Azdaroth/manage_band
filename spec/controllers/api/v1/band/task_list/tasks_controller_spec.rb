require 'rails_helper'


describe Api::V1::Band::TaskList::TasksController do

  let!(:band) { create(:band) }
  let!(:user) { create(:user) }
  let!(:task_list) { create(:task_list, band: band) }
  let!(:task) { create(:task, list: task_list, name: "name") }

	it_behaves_like 'requires_authentication', [:show, :index, :create, :update, :destroy]

  before(:each) do
    user.bands << band
  end

  describe "#update" do

    before(:each) do
      stub_current_user(user)
    end

    let(:params) {
      {
        task: {
          name: "new task name"
        }
      }.merge(band_id: band.id, task_list_id: task_list.id, id: task.id)
    }

    it "updates task" do
      expect do
        post :update, params
      end.to change { task.reload.name }.from("name").to("new task name")
    end

    it "renders json" do
      post :update, params
      expected_result = {
        "task" => {
          "name" => "new task name",
          "position" => 0,
          "id" => task.id,
          "list_id" => task_list.id
        }
      }
      expect(parsed_response).to eq expected_result
    end

  end

end