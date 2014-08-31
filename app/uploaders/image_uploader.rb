class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :fog

  version :medium do
    process :crop
    resize_to_fill(300, 300)
  end

  version :large do
    process :crop
    resize_to_fill(600, 600)
  end

  def filename
     "#{secure_token}.#{file.extension}" if original_filename.present?
  end

  def cache_dir
    "#{Rails.root}/tmp/uploads"
  end

  def store_dir
    "uploads/#{ENV['S3_STORAGE_DIR'] || 'files'}/"
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end

  protected

  def crop
    if model.cropping?
      manipulate! do |img|
        x = model.crop_x
        y = model.crop_y
        w = model.crop_w
        h = model.crop_h

        img.crop("#{w}x#{h}+#{x}+#{y}")
        img
      end
    end
  end

  def secure_token
    var = :"@#{mounted_as}_secure_token"
    model.instance_variable_get(var) || model.instance_variable_set(var, SecureRandom.uuid)
  end
end
