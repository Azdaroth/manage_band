require 'rails_helper'

describe Api::V1::BandsController do

  let!(:user) { create(:user, :with_bands) }
  let!(:other_band) { create(:band) }

  it_behaves_like 'requires_authentication', [:index, :show]

  describe "#index" do

    it "retuns list of bands" do
      stub_current_user(user)
      get :index
      band = user.bands.first
      expected_result = { "bands" => [{ "id" => band.id, "name" => band.name }] }
      expect(parsed_response).to eq expected_result
    end

  end

  describe "#show" do
    it "returns band's data" do
      stub_current_user(user)
      band = user.bands.first
      get :show, id: band.id
      expected_result = { "band" => { "id" => band.id, "name" => band.name } }
      expect(parsed_response).to eq expected_result
    end
  end

end