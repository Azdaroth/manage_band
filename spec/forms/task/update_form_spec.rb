require 'rails_helper'

describe Task::UpdateForm do

  let(:band) { build_stubbed(:band) }
  let(:task) { build_stubbed(:task) }

  subject { Task::UpdateForm.new(task, band: band) }

  context "validation" do

    context "list_id validation" do

      before(:each) do
        allow(band).to receive(:task_list_ids) { [1] }
      end

      it "is ok if list belongs to band" do
        subject.validate(list_id: 1)
        expect(subject.errors).to be_empty
      end

      it "adds error message if list does not belong to band" do
        subject.validate(list_id: 2)
        expect(subject.errors.messages[:list_id]).to be_present
      end

    end

  end

end