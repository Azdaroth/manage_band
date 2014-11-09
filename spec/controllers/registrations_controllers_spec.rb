require 'rails_helper'

# it's been overridden and refactored so requires tests

describe RegistrationsController do

  describe "#create" do

    let(:valid_params) {
      {
        email: "email@example.com",
        password: "foobar123",
        password_confirmation: "foobar123",
        confirm_success_url: "http://google.pl",
        band_name: "Death Levels All"
      }
    }

    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
    end

    context "happy path" do

      it "creates user" do
        expect do
          post :create, valid_params
        end.to change(User, :count).by(1)
      end

      it "creates band and assigns user to it" do
        expect do
          post :create, valid_params
        end.to change(Band, :count).by(1)
        last_user = User.last
        expect(last_user.bands.count).to eq 1
        expect(last_user.bands.first.name).to eq "Death Levels All"
      end

      it "returns json with user" do
        post :create, valid_params
        last_user = User.last
        expected_response = {
          status: "success",
          data: last_user
        }.to_json
        expect(response.body).to eq expected_response
      end

      it "sends confirmation instructions" do
        expect do
          post :create, valid_params
        end.to change { all_emails_sent_count }.by(1)
        expect(last_email.subject).to match /Confirmation/
      end

    end

  end

end