class Wall < ActiveRecord::Base
  extend FriendlyId
  friendly_id :wall_name, :use => :slugged

  belongs_to :user
  has_many :posts
end
