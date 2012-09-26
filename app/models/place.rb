require 'activerecord-import'

class Place < ActiveRecord::Base
  has_many :checkins

  def build_from_checkin(checkin)
    self.address = "#{checkin.place.location.street} #{checkin.place.location.city} #{checkin.place.location.state}"
    self.name = checkin.place.name
    self.facebook_place_id = checkin.place.id
    self.facebook_id = checkin.id
    self.created_at = checkin.created_time
    self.likes = checkin.place.likes
    self.checkin_count = checkin.place.checkins
    self.picture = checkin.place.picture
    self.category = checkin.place.category
    self.lat = checkin.place.location.latitude
    self.long = checkin.place.location.longitude
  end
  
  def get_picture_for_place(graph)
    unless picture
      puts facebook_id.inspect
      begin
        place_object = graph.get_object(facebook_id)
      rescue
        return false
      end
      fb_place = Facebook::Place.new(place_object, graph)
      update_attributes(name: fb_place.name, picture: fb_place.picture, category: fb_place.category, likes: fb_place.likes, checkin_count: fb_place.checkins)
      return true
    end
  end
  
  def self.categories(time)
    rounded_time = Time.local(time.year, time.month, 1, 0, 0)
    max_time = rounded_time + 1.month
    categories = []
    token = User.me.token
    graph = Koala::Facebook::API.new(token)
    Place.where("created_at > ? and created_at < ?", rounded_time, max_time).each do |place|
      place.get_picture_for_place(graph)
      categories << place.category
    end
    return categories
  end
  
  def self.places_for_categories(category)
    Place.find_all_by_category(category)
  end
  
  def self.top_places
    top_places = {}
    places_hash = Checkin.all.group_by{|c| c.place_id}
    places_hash.each do |key,value|
      if value.count > 1
        top_places["#{Place.find(key).name}"] = value.count
      end
    end
    return Hash[top_places.sort{|a,b| b.last<=>a.last}.first(7)]
  end

  private

  def set_name_if_none_given
    if name.to_s.blank?
      address_split = address.split(" ")
      self.name = address_split.try(:first).to_s + address_split.try(:second).to_s
    end
  end
end
