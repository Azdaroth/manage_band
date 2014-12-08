require 'rails_helper'

describe Asset::DeepLinker do

  let!(:band) { create(:band) }
  let!(:asset_list) { create(:asset_list, band: band) }
  let!(:asset_1) { create(:asset, list: asset_list) }
  let!(:asset_2) { create(:asset, list: asset_list) }
  let!(:asset_3) { create(:asset, list: asset_list) }

  subject { Asset::DeepLinker.new(band) }

  describe "#link" do

    let(:tree_params) {
      [
        {
          "item" => {"id" => asset_1.id},
          "children" => [{"item" => {"id" => asset_2.id }}]
        },
        {
          "item" => {"id" => asset_3.id},
          "children" => nil
        }
      ]
    }

    it "links assets together in tree structure with proper position" do
      subject.link(tree_params)

      asset_1.reload
      asset_2.reload
      asset_3.reload

      expect(asset_1.asset).to eq nil
      expect(asset_1.assets.count).to eq 1
      expect(asset_1.assets).to include asset_2

      expect(asset_2.asset).to eq asset_1
      expect(asset_2.assets).to be_empty

      expect(asset_3.asset).to eq nil
      expect(asset_3.assets).to be_empty

      expect(asset_1.position).to eq 0
      expect(asset_2.position).to eq 0
      expect(asset_3.position).to eq 1
    end

  end

end