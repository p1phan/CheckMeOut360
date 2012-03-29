class Place < ActiveRecord::Base
  has_many :checkins
  # geocoded_by :address, :latitude => :lat, :longitude => :long
  # after_validation :geocode
  # before_save :set_name_if_none_given
  
  def build_from_checkin(checkin)
    self.address = "#{checkin.place.location.street} #{checkin.place.location.city} #{checkin.place.location.state}"
    self.name = checkin.place.name
    self.facebook_place_id = checkin.place.id
    self.facebook_id = checkin.id
    self.created_at = checkin.created_time
    self.likes = checkin.place.likes
    self.checkin_count = checkin.place.checkins
    self.picture = checkin.place.picture
    self.description = checkin.place.description
    self.category = checkin.place.category
    self.lat = checkin.place.location.latitude
    self.long = checkin.place.location.longitude
  end

  def set_name_if_none_given
    if name.to_s.blank?
      address_split = address.split(" ")
      self.name = address_split.try(:first).to_s + address_split.try(:second).to_s
    end
  end

  def self.places_for_users_checkin(user)
    user.checkins.collect{|c| 
      puts c.place.inspect
    }
  end
end
