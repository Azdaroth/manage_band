require 'rails_helper'

describe User::BandsController do

  let!(:user) { create(:user, :with_bands) }
  let!(:order_band) { create(:band) }

  describe "#index" do

    it "requires authentication" do
      get :index
      expected_result = { "errors" => ["Authorized users only."] }
      expect(parsed_response).to eq expected_result
    end

    it "retuns list of bands" do
      allow(controller).to receive(:authenticate_user!) { true }
      allow(controller).to receive(:current_user) { user }
      get :index
      band = user.bands.first
      expected_result = { "bands" => [{ "id" => band.id, "name" => band.name }] }
      expect(parsed_response).to eq expected_result
    end

  end

end