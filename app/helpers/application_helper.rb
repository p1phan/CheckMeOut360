module ApplicationHelper

  def active_users
    User.active
  end
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
  
  def day_format(date)
    today = Time.now
    date_diff = today.day - date.day
    if date.month == today.month
      if date_diff > 21
        return "4 weeks ago"
      elsif date_diff > 14
        return "3 weeks ago"
      elsif date_diff > 7
        return  "a week ago"
      else
        return ""
      end
    else
      return "#{date.month - today.month} month ago"
    end
  end

end
