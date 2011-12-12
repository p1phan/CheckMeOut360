class Place < ActiveRecord::Base
  has_and_belongs_to_many :users
  
  geocoded_by :address, :latitude => :lat, :longitude => :long
  after_validation :geocode
  # validate :address_should_be_valid
  
  def address_should_be_valid
    unless lat && long
      
    end
  end
end
