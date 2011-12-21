class User < ActiveRecord::Base
  belongs_to :user, :dependent => :destroy
  belongs_to :place
end