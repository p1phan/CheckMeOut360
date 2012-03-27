class Checkin < ActiveRecord::Base
  belongs_to :place
  has_and_belongs_to_many :users

  def self.build_checkins(checkins, token)
    graph = Koala::Facebook::API.new(token)
    checkins.each do |checkin|
      facebook_checkin = Checkin.find_or_initialize_by_facebook_checkin_id(checkin.id)
      if facebook_checkin.new_record?

        facebook_place = Place.find_or_initialize_by_facebook_place_id(checkin.place.id)
        facebook_checkin.place = facebook_place
        if facebook_place.new_record?
          facebook_place.build_from_checkin(checkin)
          facebook_place.save!
        end

        facebook_user_tags = checkin.tags << checkin.from
        facebook_user_tags.each do |user|
          facebook_user = User.find_or_initialize_by_uid(user.id)
          if facebook_user.new_record?
            facebook_user.email = valid_available_email(user.name.downcase.gsub(" ", "")+"@checkmeout360.com")
            facebook_user.password = user.name.downcase.gsub(" ", "")
            facebook_user.password_confirmation = user.name.downcase.gsub(" ", "")
            facebook_profile = facebook_user.build_profile
            facebook_profile.first_name = user.name.split(" ").first
            facebook_profile.last_name = user.name.split(" ").last
            facebook_profile.remote_profile_picture_url = graph.get_picture(user.id, :type => "large")
            
            facebook_user.save!
          end
          facebook_checkin.users << facebook_user
        end

        facebook_checkin.message = checkin.message
        facebook_checkin.created_at = checkin.created_time
        facebook_checkin.save
      end
    end
  end
  
  def self.valid_available_email(email)
    if User.exists?(email: email)
      valid_available_email(email + rand(10).to_s)
    else
      return email
    end
  end

end
