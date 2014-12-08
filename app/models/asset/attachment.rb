class Asset::Attachment < ActiveRecord::Base

  mount_uploader :file, AssetFileUploader

  belongs_to :asset
  belongs_to :band

end
