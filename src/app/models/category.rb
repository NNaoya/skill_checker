class Category < ApplicationRecord
  has_many :skills

  mount_uploader :title_image, ImageUploader
  mount_uploader :icon_image, ImageUploader
end
