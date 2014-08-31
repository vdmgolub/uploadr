class ImageBuilder
  def build(params)
    image = Image.new(params)
    image.remote_file_url = params[:temp_url]

    image
  end
end
