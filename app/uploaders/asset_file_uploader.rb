class AssetFileUploader < CarrierWave::Uploader::Base

  storage :file

  CarrierWave::SanitizedFile.sanitize_regexp = /[^[:word:]\.\-\+]/

  def store_dir
    "system/#{Rails.env}/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

end
