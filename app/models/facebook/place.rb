class Facebook::Place < Hashie::Trash
  property :id
  property :name
  property :location
  property :picture
  property :category
  property :checkins
  property :likes

  def initialize(place_hash, graph)
    place_hash.each do |key,value|
      if key == "location"
        self[key.to_sym] = Facebook::Location.new(value)
      elsif key == "id"
        self[key.to_sym] = value
        if graph
          fb_place_extra = graph.get_object(value)
          self.picture = fb_place_extra['picture']
          self.category = fb_place_extra['category']
          self.checkins = fb_place_extra['checkins']
          self.likes = fb_place_extra['likes']
        end
      else
        self[key.to_sym] = value
      end
    end
  end

end