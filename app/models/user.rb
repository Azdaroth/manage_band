class User < ActiveRecord::Base

  include DeviseTokenAuth::Concerns::User

  has_many :band_users
  has_many :bands, through: :band_users

end
