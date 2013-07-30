class Note < ActiveRecord::Base
  attr_accessible :content, :image, :tags, :user_id
  
  belongs_to :user
  
  mount_uploader :image, ImageUploader
  
  
end
