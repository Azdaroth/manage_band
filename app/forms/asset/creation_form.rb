class Asset::CreationForm < Reform::Form

  attr_reader :band
  private     :band

  property :name
  property :asset_attachment_id, empty: true
  property :attachment
  property :tag_list, empty: true

  validates :name, :asset_attachment_id, presence: true

  def initialize(model, args = {})
    @band = args.fetch(:band)
    super(model)
  end

  def sync_models
    assign_asset_attachment
    super
  end

  def persist(params)
    if validate(params)
      sync_models
      tag_asset_with_band_as_the_tagger
      save
    end
  end

  private

    def tag_asset_with_band_as_the_tagger
      band.tag(model, with: tag_list, on: :tags)
    end

    def assign_asset_attachment
      self.attachment = model.band.find_asset_attachment(asset_attachment_id)
    end

end