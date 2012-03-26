class Profile < ActiveRecord::Base
  belongs_to :user
  mount_uploader :profile_picture, ProfilePictureUploader
  
  def full_name
    first_name + " " + last_name
  end
  
  def to_param
    set_next_available_wall_name(email.split("@").first)
  end
  
  def set_next_available_wall_name(possible_profile_name)
    if Wall.exists?(wall_name: possible_profile_name)
      self.wall_name = set_next_available_wall_name(possible_profile_name + rand(100).to_s)
    else
      self.wall_name = possible_profile_name
    end
  end
  
end
