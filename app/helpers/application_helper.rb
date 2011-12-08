module ApplicationHelper

  def strip_new_line(str)
    str.gsub("\n", "")
  end
  
  def get_facebook_image_size(base_url, image_size)
    if base_url
      base_url.gsub("type=square", "type=#{image_size}")
    else
      return "empty_facebook_picture.jpg"
    end
  end

end
