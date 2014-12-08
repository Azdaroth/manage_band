require 'rails_helper'

describe Api::V1::Band::AssetsController do

  let!(:band) { build_stubbed(:band) }
  let!(:user) { build_stubbed(:user) }

  it_behaves_like 'requires_authentication', [:link]

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
        "band_id"=> band.id,
        "assets_tree" => tree_params
      }
      post :link, params
      expect(linker).to have_received(:link).with(tree_params)
    end

  end

end