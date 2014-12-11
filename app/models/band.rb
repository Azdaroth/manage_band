class Band < ActiveRecord::Base

  acts_as_tagger

  has_many :asset_attachments, class_name: "Asset::Attachment"
  has_many :asset_lists
  has_many :assets, through: :asset_lists
  has_many :band_users
  has_many :users, through: :band_users
  has_many :task_lists

  validates :name, presence: true, uniqueness: true

  def find_asset_attachment(asset_attachment_id)
    asset_attachments.find(asset_attachment_id)
  end

end
