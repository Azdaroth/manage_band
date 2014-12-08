require 'rails_helper'

describe AssetListSerializer do

  let(:asset_attachment) { build_stubbed(:asset_attachment) }
  let(:asset) { build_stubbed(:asset, name: "root asset", attachment: asset_attachment) }
  let(:asset_list) { build_stubbed(:asset_list, name: "list", created_at: DateTime.parse("08-12-2014 12:00:00")) }

  before(:each) do
    allow(asset_list).to receive(:assets_without_parent) { [asset] }
  end

  subject { AssetListSerializer.new(asset_list) }

  before(:each) do
    ENV["HOST"] = "http://manage_band.dev"
  end

  describe "#to_json" do

    it "returns json with item hash and children without root" do
      # ap JSON.parse(subject.to_json)
      result = {
        "asset_list" => {
          "created_at" => "2014-12-08T13:00:00.000+01:00",
          "id" => asset_list.id,
          "name" => "list" ,
          "tag_list" => [],
          "assets" => [],
          "assets_without_parent" => [
            {
              "item" => {
                "id" => asset.id,
                "name" => "root asset",
                "file_url" => "http://manage_band.dev#{asset_attachment.file.url}",
                "tag_list" => []
              },
              "children" => []
            }
          ]
        }
      }
      expect(result).to eq JSON.parse(subject.to_json)
    end

  end

end