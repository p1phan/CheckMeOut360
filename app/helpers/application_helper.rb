module ApplicationHelper

  def strip_new_line(str)
    str = str.gsub("\n", "")
    str = str.gsub("'", "&apos;")
  end
  
  def display_profile_picture(profile_picture)
    if profile_picture.blank?
      "empty_facebook_picture.jpg"
    else
      profile_picture
    end
  end
  
  def get_current_wall
    @wall || current_user.try(:wall)
  end
  
  def wall_for_user(user_id)
    User.find(user_id).wall.slug
  end

end
