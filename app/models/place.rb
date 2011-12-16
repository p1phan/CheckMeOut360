class Place < ActiveRecord::Base
  has_and_belongs_to_many :users
  
  geocoded_by :address, :latitude => :lat, :longitude => :long
  after_validation :geocode
  validates :address, :presence => :true, :length => {:minimum => 4, :message => "is too short!"}, :uniqueness => {:message => "was already created!"}
  before_save :set_name_if_none_given
  
  def build_from_checkin(checkin)
    self.address = "#{checkin.place.location.street} #{checkin.place.location.city} #{checkin.place.location.state}"
    self.name = checkin.place.name
    self.count = count+1
  end

  def set_name_if_none_given
    if name.to_s.blank?
      address_split = address.split(" ")
      self.name = address_split.try(:first).to_s + address_split.try(:second).to_s
    end
  end
  
  def self.get_checkins(token)
    @checkins = []
    graph = Koala::Facebook::API.new(token)
    facebook_checkins_for_user = graph.get_connections("me", "checkins")
    facebook_checkins_for_user.each do |facebook_checkin|
      @checkins << Facebook::Checkin.new(facebook_checkin)
    end
    return @checkins
  end
end
