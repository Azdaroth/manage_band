require 'rails_helper'

describe AssetSerializer do

  let(:asset_attachment) { build_stubbed(:asset_attachment) }
  let(:asset) { build_stubbed(:asset, name: "root asset", attachment: asset_attachment) }
  let(:nested_asset) { build_stubbed(:asset, name: "nested asset") }

  before(:each) do
    allow(asset).to receive(:assets) { [nested_asset] }
  end

  subject { AssetSerializer.new(asset) }

  before(:each) do
    ENV["HOST"] = "http://manage_band.dev"
  end

  describe "#to_json" do

    it "returns json with item hash and children without root" do
      result = {
        "asset" => {
          "item" => {
            "id" => asset.id,
            "name" => "root asset",
            "file_url" => "http://manage_band.dev#{asset_attachment.file.url}",
            "tag_list" => [],
            "asset_attachment_id" => asset_attachment.id
          },
          "children" => [
            "item" => {
              "id" => nested_asset.id,
              "name" => "nested asset",
              "file_url" => nil,
              "tag_list" => [],
              "asset_attachment_id" => nil
            },
            "children" => []
          ]
        }
      }
      expect(result).to eq JSON.parse(subject.to_json)
    end

  end

end