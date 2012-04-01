class Facebook::Place < Hashie::Trash
  property :id
  property :name
  property :location
  property :picture
  property :category
  property :checkins
  property :likes
  property :from

  def initialize(hash, graph)
    place_hash = hash
    place_hash = hash['place'] if hash.keys.include?('place')
    
    place_hash.each do |key,value|
      if key == "location"
        self[key.to_sym] = Facebook::Location.new(value)
      elsif key == "name"
        self[key.to_sym] = value
      elsif key == "id"
        self[key.to_sym] = value
        if graph
          fb_place_extra = graph.get_object(value)
          self.picture = fb_place_extra['picture']
          self.category = fb_place_extra['category']
          self.checkins = fb_place_extra['checkins']
          self.likes = fb_place_extra['likes']
        end
      end
    end
  end

end