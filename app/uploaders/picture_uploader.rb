class PictureUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  storage :ftp

  def filename
    "#{secure_token(10)}.#{file.extension}" if original_filename.present?
  end

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  version :large do
    resize_to_limit(1920, 1920)
  end

  version :big do
    resize_to_limit(420, 420)
  end

  version :medium do
    resize_to_fit(320, 320)
  end

  version :micro do
    resize_to_fit(60, 60)
  end

  def extension_white_list
    %w(jpg jpeg png)
  end

  def default_url
    ActionController::Base.helpers.asset_path("/logo.svg")
  end

  protected
    def secure_token(length=16)
      var = :"@#{mounted_as}_secure_token"
      model.instance_variable_get(var) or model.instance_variable_set(var, SecureRandom.hex(length/2))
    end
end
