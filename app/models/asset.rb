class Asset < ActiveRecord::Base

  acts_as_taggable

  delegate :band, to: :list, allow_nil: false, prefix: false

  scope :without_parent, -> { where(asset_id: nil) }
  scope :by_position, -> { order(position: :asc) }

  has_many :assets, dependent: :destroy
  has_one :attachment, dependent: :destroy

  belongs_to :asset
  belongs_to :list, class_name: "AssetList"
  belongs_to :band

  validates :band, :name, presence: true

  def assets_by_position
    assets.by_position
  end

end
