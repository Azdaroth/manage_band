require 'rails_helper'

describe Api::V1::Band::AssetList::AssetsController do

  let!(:band) { create(:band) }
  let!(:user) { create(:user) }
  let!(:asset_list) { create(:asset_list, band: band) }
  let!(:asset_attachment) { create(:asset_attachment, band: band) }
  let!(:asset) { create(:asset, list: asset_list, name: "name") }

  before(:each) do
    user.bands << band
    ENV["HOST"] = "http://manage_band.dev"
  end

  it_behaves_like 'requires_authentication', [:link, :show, :index, :create, :update, :destroy]

  describe "#show" do

    before(:each) do
      stub_current_user(user)
    end

    it "returns serialized asset" do
      expected_result = {
        "asset" => {
          "item" => {
            "id" => asset.id,
            "name" => asset.name,
            "file_url" => nil,
            "tag_list" => [],
            "asset_attachment_id" => nil
          },
          "children"  => []
        }
      }
      get :show, band_id: band.id, asset_list_id: asset_list.id, id: asset.id
      expect(parsed_response).to eq expected_result
    end

  end

  describe "#link" do

    let(:tree_params) {
      []
    }

    let(:linker) { instance_double("Asset::DeepLinker", link: true) }
    let(:user_bands) { Band }

    before(:each) do
      allow(user).to receive(:bands) { user_bands }
      allow(user_bands).to receive(:find).with(band.id.to_s) { band }
      allow(Asset::DeepLinker).to receive(:new).with(band) { linker }
    end

    it "links assets together" do
      stub_current_user(user)
      params = {
        "band_id" => band.id,
        "asset_list_id" => asset_list.id,
        "assets_tree" => tree_params
      }
      post :link, params
      expect(linker).to have_received(:link).with(asset_list, tree_params)
    end

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
            "tag_list" => [],
            "asset_attachment_id" => asset_attachment.id
          },
          "children"  => []
        }
      }
      expect(parsed_response).to eq expected_result
    end

  end

  describe "#update" do

    before(:each) do
      stub_current_user(user)
    end

    let(:params) {
      {
        asset: {
          name: "new asset name",
          asset_attachment_id: asset_attachment.id
        }
      }.merge(band_id: band.id, asset_list_id: asset_list.id, id: asset.id)
    }

    it "updates asset" do
      expect do
        post :update, params
      end.to change { asset.reload.name }.from("name").to("new asset name")
    end

    it "renders json" do
      post :update, params
      expected_result = {
        "asset" => {
          "item" => {
            "id" => asset.id,
            "name" => "new asset name",
            "file_url" => "http://manage_band.dev/system/test/asset/attachment/file/#{asset_attachment.id}/rails.png",
            "tag_list" => [],
            "asset_attachment_id" => asset_attachment.id
          },
          "children"  => []
        }
      }
      expect(parsed_response).to eq expected_result
    end

  end

  describe "#destroy" do

    before(:each) do
      stub_current_user(user)
    end

    it "destroys asset" do
      params = { band_id: band.id, asset_list_id: asset_list.id, id: asset.id }
      expect do
        post :destroy, params
      end.to change { asset_list.assets.count }.by(-1)
    end

  end

end