require 'activerecord-import'

class Checkin < ActiveRecord::Base
  belongs_to :place
  has_and_belongs_to_many :users

  def self.build_checkins(checkins)
    ActiveRecord::Base.transaction do
    @all_checkins = Checkin.all
    @all_places = Place.all
    @all_users = User.all
    
    checkins.each do |checkin|
      facebook_checkin = find_or_init_checkin(checkin.id)
      if facebook_checkin.new_record?
        facebook_place = find_or_init_place(checkin.place.id)
        facebook_checkin.place = facebook_place
        if facebook_place.new_record?
          facebook_place.build_from_checkin(checkin)
          facebook_place.save!
          @all_places << facebook_place
        end
        facebook_user_tags = checkin.tags << checkin.from
        facebook_user_tags.each do |user|
          facebook_user = find_or_init_user(user.id)
          if facebook_user.new_record?
            facebook_user.uid = user.id
            facebook_user.name = user.name
            facebook_user.email = user.name.downcase.gsub(" ", "")+"#{rand(10).to_s}" + "@checkmeout360.com"
            facebook_user.password = user.name.downcase.gsub(" ", "")
            facebook_user.password_confirmation = user.name.downcase.gsub(" ", "")
            # facebook_user.remote_profile_picture_url = graph.get_picture(user.id, :type => "large")
            facebook_user.save!
            @all_users << facebook_user
          end
          facebook_checkin.users << facebook_user
        end
        facebook_checkin.message = checkin.message
        facebook_checkin.created_at = checkin.created_time
        facebook_checkin.save!
        @all_checkins << facebook_checkin
      end
    end
    end
  end
  
  def self.get_checkins_facebook_url(user)
    token = user.token
    @checkins = []
    graph = Koala::Facebook::API.new(token)
    facebook_checkins_for_user = graph.get_connections("me", "checkins")
    while(facebook_checkins_for_user.size != 0)
      facebook_checkins_for_user.each do |facebook_checkin|
        checkin = Facebook::Checkin.new(facebook_checkin)
        @checkins << checkin
      end
      facebook_checkins_for_user = facebook_checkins_for_user.next_page
    end
    
    # next_facebook_checkins_for_user = nil
    # index = 0
    # while (true)
    #   next_facebook_checkins_for_user = facebook_checkins_for_user.next_page
    #   return @checkins if next_facebook_checkins_for_user.size == 0
    #   if index == 0
    #     fcl = user.facebook_checkin_logs.build(next: facebook_checkins_for_user.paging['next'], previous: nil, done: false)
    #     fcl.current = next_facebook_checkins_for_user.paging['previous'] if next_facebook_checkins_for_user.size != 0
    #   else
    #     fcl = user.facebook_checkin_logs.build(current: facebook_checkins_for_user.paging['next'],
    #                next: next_facebook_checkins_for_user.paging['next'], previous: next_facebook_checkins_for_user.paging['previous'], done: false)
    #   end
    #   facebook_checkins_for_user = next_facebook_checkins_for_user
    #   index = index + 1
    #   fcl.save!
    # end
    return @checkins
  end

  def self.store_checkins(token, facebook_checkin_url)
    graph = Koala::Facebook::API.new(token)
    
    raw_request = RestClient.get(facebook_checkin_url)
    checkins_json = ActiveSupport::JSON.decode(raw_request)
    @checkins = []
    checkin_data = checkins_json['data']
    checkin_data.each do |facebook_checkin|
      checkin = Facebook::Checkin.new(facebook_checkin)
      @checkins << checkin
    end
    return @checkins
  end
  
  private
  
  def self.valid_available_email(email)
    if User.exists?(email: email)
      valid_available_email(email + rand(10).to_s)
    else
      return email
    end
  end
  
  def self.find_or_init_checkin(checkin_id)
    index = @all_checkins.collect{|checkin| checkin.facebook_checkin_id}.find_index(checkin_id)
    if index
      return @all_checkins[index]
    else
      return Checkin.new(facebook_checkin_id: checkin_id)
    end
  end
  
  def self.find_or_init_place(fb_place_id)
    index = @all_places.collect{|place| place.facebook_place_id}.find_index(fb_place_id)
    if index
      return @all_places[index]
    else
      return Place.new(facebook_place_id: fb_place_id)
    end
  end
  
  def self.find_or_init_user(fb_uid)
    index = @all_users.collect{|user| user.uid}.find_index(fb_uid)
    if index
      return @all_users[index]
    else
      return User.new
    end
  end

end
