class Facebook::Place < Hashie::Trash
  property :id
  property :name
  property :location

  def initialize(place_hash)
    place_hash.each do |key,value|
      if key == "location"
        self[key.to_sym] = Facebook::Location.new(value)
      else
        self[key.to_sym] = value
      end
    end
  end

end