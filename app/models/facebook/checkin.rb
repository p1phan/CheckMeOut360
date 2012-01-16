class Facebook::Checkin < Hashie::Trash
  property :id
  property :from
  property :tags
  property :message
  property :place
  property :application
  property :likes
  property :comments
  property :created_time

  def initialize(checkin_hash)
    self.tags = []
    checkin_hash.each do |key,value|
      if key == "place"
        self[key.to_sym] = Facebook::Place.new(value)
      elsif key == "tags"
        value['data'].each do |tags_hash|
          next unless tags_hash
          self.tags << Facebook::Tag.new(:name => tags_hash['name'], :id => tags_hash['id'])
        end
      elsif key == "from"
        self[key.to_sym] = Facebook::From.new(value)
      else
        self[key.to_sym] = value
      end
    end
  end

end