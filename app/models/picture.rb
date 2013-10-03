class Picture < ActiveRecord::Base
  mount_uploader :image, ImageUploader
  belongs_to :imageable, polymorphic: true
  attr_accessible :image, :imageable_id, :imageable_type
end
