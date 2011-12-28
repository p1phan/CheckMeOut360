class Facebook::From < Hashie::Trash
  property :id
  property :name

  def initialize(from_hash)
    from_hash.each do |key,value|
      self[key.to_sym] = value
    end
  end

end