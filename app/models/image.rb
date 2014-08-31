class Image < ActiveRecord::Base
  attr_accessor :temp_url, :crop_x, :crop_y, :crop_w, :crop_h
end
