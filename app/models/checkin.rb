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
              facebook_user.populate_user(user)
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
    begin
      facebook_checkins_for_user = graph.get_connections("me", "checkins")
    rescue Koala::Facebook::APIError => e
      return e
    end
    
    while(facebook_checkins_for_user.size != 0)
      facebook_checkins_for_user.each do |facebook_checkin|
        checkin = Facebook::Checkin.new(facebook_checkin)
        @checkins << checkin
      end
      facebook_checkins_for_user = facebook_checkins_for_user.next_page
    end

    return @checkins
  end

  def self.store_checkins(token, facebook_checkin_url)
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

  def self.oldest_checkin
    Checkin.order("created_at").first
  end

  def self.checkins_count_by_month(year)
    checkins_hash = Checkin.where("date(created_at) > ? and date(created_at) < ?", DateTime.new(year), DateTime.new(year+1)).group_by{ |t| t.created_at.month }
    month_array = [0,0,0,0,0,0,0,0,0,0,0,0]
    checkins_hash.each do |key,value|
      month_array[key-1] = value.count
    end
    return month_array
  end

end
