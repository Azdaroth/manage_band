class AssetList < ActiveRecord::Base

  acts_as_taggable

  has_many :assets, foreign_key: "list_id"

  belongs_to :band

  validates :name, presence: true

  def assets_without_parent
    assets.without_parent
  end

end
