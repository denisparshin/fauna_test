class TopSlider < ActiveRecord::Base
  mount_uploader :file, PictureUploader
end
