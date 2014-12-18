class Task::UpdateForm < Reform::Form

  attr_reader :band
  private     :band

  property :name
  property :position
  property :list_id

  validate :list_belongs_to_band

  def initialize(model, args = {})
    @band = args.fetch(:band)
    super(model)
  end

  def persist(params)
    if validate(params)
      sync_models
      save
    end
  end

  private

    def list_belongs_to_band
      if list_id.present? && !band.task_list_ids.include?(list_id)
        errors.add(:list_id, I18n.t('errors.messages.list_does_not_belong_to_band', band_name: band.name))
      end
    end

end