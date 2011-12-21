module ApplicationHelper

  def strip_new_line(str)
    str.gsub("\n", "")
  end
  
  def display_profile_picture(profile_picture)
    if profile_picture.blank?
      "empty_facebook_picture.jpg"
    else
      profile_picture
    end
  end
  
  def get_current_wall
    @wall || current_user.try(:wall) || User.first.try(:wall)
  end

end
