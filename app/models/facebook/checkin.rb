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
    checkin_hash.each do |key,value|
      if key == "place"
        self[key.to_sym] = Facebook::Place.new(value)
      else
        self[key.to_sym] = value
      end
    end
  end

end