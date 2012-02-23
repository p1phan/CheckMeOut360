class Profile < ActiveRecord::Base
  belongs_to :user
  mount_uploader :profile_picture, ProfilePictureUploader
  
  def full_name
    first_name + " " + last_name
  end
end
