class Asset < ActiveRecord::Base

  acts_as_taggable

  has_many :assets

  belongs_to :asset
  belongs_to :band

  validates :band, :file, :name, presence: true

  mount_uploader :file, AssetFileUploader

end
