class Place < ActiveRecord::Base
  has_and_belongs_to_many :users
  
  geocoded_by :address, :latitude => :lat, :longitude => :long
  after_validation :geocode
  validates :address, :presence => :true, :length => {:minimum => 4, :message => "is too short!"}, :uniqueness => {:message => "was already created!"}
  before_save :set_name_if_none_given
  
  def set_name_if_none_given
    unless name
      address_split = address.split(" ")
      self.name = address_split.try(:first).to_s + address_split.try(:second).to_s
    end
  end
end
