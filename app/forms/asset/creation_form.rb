class Asset::CreationForm < Reform::Form

  property :name
  property :asset_attachment_id, empty: true
  property :attachment

  validates :name, :asset_attachment_id, presence: true

  def sync_models
    assign_asset_attachment
    super
  end

  def persist(params)
    if validate(params)
      sync_models
      save
    end
  end

  private

    def assign_asset_attachment
      self.attachment = model.band.find_asset_attachment(asset_attachment_id)
    end

end