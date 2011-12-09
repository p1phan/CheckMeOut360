class Wall < ActiveRecord::Base
  extend FriendlyId
  friendly_id :wall_name, :use => :slugged

  belongs_to :user
  has_many :posts
  
  def set_next_available_wall_name(possible_wall_name)
    if Wall.exists?(wall_name: possible_wall_name)
      self.wall_name = set_next_available_wall_name(possible_wall_name + rand(100).to_s)
    else
      self.wall_name = possible_wall_name
    end
  end
end
