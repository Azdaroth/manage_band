class Asset < ActiveRecord::Base

  acts_as_taggable

  delegate :band, to: :list, allow_nil: false, prefix: false

  has_many :assets
  has_one :attachment

  belongs_to :asset
  belongs_to :list, class_name: "AssetList"
  belongs_to :band

  validates :band, :name, presence: true

end
