class Image < ActiveRecord::Base
  attr_accessor :temp_url, :crop_x, :crop_y, :crop_w, :crop_h

  mount_uploader :file, ImageUploader

  def cropping?
    !crop_x.blank? && !crop_y.blank? && !crop_w.blank? && !crop_h.blank?
  end
end
