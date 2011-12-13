class Place < ActiveRecord::Base
  has_and_belongs_to_many :users
  
  geocoded_by :address, :latitude => :lat, :longitude => :long
  after_validation :geocode
  validates :address, :presence => :true, :length => {:minimum => 4, :message => "Name of Place is too short!"}, :uniqueness => {:message => "Place was already created!"}

end
