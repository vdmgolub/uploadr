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

  def create
    @image = ImageBuilder.new.build(create_params)

    if @image.save
      redirect_to @image
    else
      redirect_to new_image_path
    end
  end

  def show
    @image = Image.find(params[:id])
  end

  protected

  def create_params
    params.require(:image).permit(:temp_url, :crop_x, :crop_y, :crop_w, :crop_h)
  end
end
