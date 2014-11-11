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

  validate :ensure_only_creator_can_be_assigned

  def persist(params)
    if validate(params)
      sync_models
      save
      true
    else
      false
    end
  end

  def sync_models
    model.bands.push(band)
    super
  end

  def save
    model.save
  end

  private

    def ensure_only_creator_can_be_assigned
      if band.persisted?
        errors.add(:band_name, I18n.t('errors.messages.must_be_invited_to_band', band_name: band_name))
      end
    end

    def band
      @band ||= Band.where(name: band_name).first_or_initialize
    end

end