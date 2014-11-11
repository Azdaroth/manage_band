class Band < ActiveRecord::Base

  acts_as_tagger

  has_many :assets
  has_many :band_users
  has_many :users, through: :band_users

  validates :name, presence: true, uniqueness: true

end
