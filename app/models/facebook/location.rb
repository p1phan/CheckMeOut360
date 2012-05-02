class Facebook::Location < Hashie::Trash
  property :street
  property :city
  property :state
  property :country
  property :zip
  property :latitude
  property :longitude
  # property :located_in

  def initialize(location_hash)
    location_hash.each do |key,value|
      self[key.to_sym] = value if self.respond_to?(key)
    end
  end

end