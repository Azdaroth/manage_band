require 'rails_helper'

describe Api::V1::Band::AssetList::AssetsController do

  let!(:band) { create(:band) }
  let!(:user) { create(:user) }
  let!(:asset_list) { create(:asset_list, band: band) }
  let!(:asset_attachment) { create(:asset_attachment, band: band) }

  before(:each) do
    user.bands << band
    ENV["HOST"] = "http://manage_band.dev"
  end

  describe "#create" do

    before(:each) do
      stub_current_user(user)
    end

    let(:params) {
      {
        asset: {
          name: "asset name",
          asset_attachment_id: asset_attachment.id
        }
      }.merge(band_id: band.id, asset_list_id: asset_list.id)
    }

    it "creates asset for assets list with attachment" do
      expect do
        post :create, params
      end.to change { asset_list.assets.count }.by(1)
    end

    it "renders json" do
      post :create, params
      asset = Asset.last
      expected_result = {
        "asset" => {
          "item" => {
            "id" => asset.id,
            "name" => "asset name",
            "file_url" => "http://manage_band.dev/system/test/asset/attachment/file/#{asset_attachment.id}/rails.png",
            "tag_list" => []
          },
          "children"  => []
        }
      }
      expect(parsed_response).to eq expected_result
    end

  end

end