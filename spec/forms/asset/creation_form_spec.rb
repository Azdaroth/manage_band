require 'rails_helper'

describe Asset::CreationForm do

  let(:asset) { build_stubbed(:asset) }
  let(:asset_attachment) { build_stubbed(:asset_attachment) }
  let(:band) { build_stubbed(:band) }

  before(:each) do
    allow(asset_attachment).to receive(:save) { true }
    allow(asset).to receive(:band) { band }
    allow(band).to receive(:find_asset_attachment).with("1") { asset_attachment }

    allow(asset).to receive(:save)
    allow(band).to receive(:tag)
  end

  subject { Asset::CreationForm.new(asset, band: band) }


  let(:params) {
    { name: "name", asset_attachment_id: "1", tag_list: "tag_name" }
  }

  describe "#sync_models" do

    it "assings asset_attachment by finding id with id" do
      subject.validate(params)
      subject.sync_models
      expect(asset.attachment).to eq asset_attachment
    end

  end

  describe "#persist" do

    it "tags asset with band as a tagger" do
      subject.persist(params)
      expect(band).to have_received(:tag).with(asset, with: "tag_name", on: :tags)
    end

  end

end