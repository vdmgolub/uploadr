class ImagesController < ApplicationController
  def index
  end

  def new
    @options = {
      key: "uploads/#{ENV['S3_TEMP_DIR']}/#{SecureRandom.hex}-{unique_id}-${filename}",
      key_starts_with: 'uploads/',
      acl: 'public-read',
      max_file_size: Integer(ENV['MAX_FILE_SIZE'] || 2).megabytes,
      id: 's3-uploader',
      class: 'upload-form',
      data: { key: :val }
    }

    @image = Image.new
  end
end
