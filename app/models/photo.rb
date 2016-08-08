class Photo < ActiveRecord::Base
  belongs_to :product
  serialize :images
  mount_uploaders :images , ImageUploader
end
