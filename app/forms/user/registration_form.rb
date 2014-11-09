class User::RegistrationForm < Reform::Form

  include Reform::Form::ActiveRecord

  property :email
  property :password
  property :password_confirmation
  property :band_name, empty: true
  property :confirm_success_url, empty: true

  validates :email, presence: true, email: true, uniqueness: { case_sensitive: false }
  validates :password, presence: true, confirmation: true, length: { minimum: 9 }
  validates :band_name, presence: true
  validates :confirm_success_url, presence: true

  def band_name=(name)
    band = Band.where(name: name).first_or_initialize
    model.bands.push(band)
  end

  def band_name
    model.bands.first.name if model.bands.any?
  end

  def persist(params)
    if validate(params)
      sync_models
      save
      true
    else
      false
    end
  end

end