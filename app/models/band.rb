class Band < ActiveRecord::Base

  has_many :band_users
  has_many :users, through: :band_users

  validates :name, presence: true, uniqueness: true

end
