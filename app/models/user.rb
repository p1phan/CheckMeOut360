require 'activerecord-import'

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :omniauthable
  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  has_many :places, :through => :checkins
  has_many :facebook_checkin_logs, :dependent => :destroy
  has_and_belongs_to_many :checkins
  has_many :user_extras
  accepts_nested_attributes_for :facebook_checkin_logs
  # accepts_nested_attributes_for :checkins

  scope :active, where("token is NOT NULL")
  scope :inactive, where("token is NULL")

  PRIVATE = 'private'.freeze
  PROTECTED = 'protected'.freeze
  PUBLIC = 'public'.freeze
  PRIVACY = [PRIVATE, PROTECTED, PUBLIC]
  validates :privacy, :inclusion => PRIVACY, allow_nil: false


  def self.find_for_facebook_oauth(access_token, signed_in_resource=nil)
    data = access_token.extra.raw_info
    if user = User.where("email = ? or uid = ?", data.email, access_token['uid']).first
      unless user.token
        user.email = data.email
        user.uid = access_token['uid']
        user.token = access_token['credentials']['token']
        user.picture = access_token.try(:info).try(:image).to_s.gsub("square", "large")
        user.name = data.first_name + " " + data.last_name
        user.location = data.work.try(:first).try(:location).try(:name)
        user.save
      end
      user.token = access_token['credentials']['token']
    else
      user = User.new(:email => data.email)
      user.uid = access_token['uid']
      user.token = access_token['credentials']['token']
      user.picture = access_token.try(:info).try(:image).to_s.gsub("square", "large")
      user.name = data.first_name + " " + data.last_name
      user.location = data.work.try(:first).try(:location).try(:name)
      user.save!(:validate => false)
    end
    return user
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["user_hash"]
        user.email = data["email"]
      end
    end
  end

  def friend_with(user)
    graph = Koala::Facebook::API.new(token)
    graph.get_connection("me", "friends").each do |friend|
      return true if friend['id'] == user.uid
    end
    return false
  end

  def unique_places
    places.order('created_at desc').uniq
  end

  def first_name
    name.split(' ')[0].downcase
  end

  def self.me
    User.find_by_email("quyminhphan@gmail.com")
  end

  def get_profile_pic(token)
    return picture if picture.present?
    begin
      @graph = Koala::Facebook::API.new(token)
      update_attribute(:picture, @graph.get_picture(uid, type: "large"))
    rescue Exception => e
    end
  end

  def populate_user(user)
    self.uid = user.id
    self.name = user.name
    self.email = user.name.downcase.gsub(" ", "#{rand(10).to_s}")+"#{rand(10).to_s}" + "@checkmeout360.com"
    self.password = user.name.downcase.gsub(" ", "")
    self.password_confirmation = user.name.downcase.gsub(" ", "")
  end

end
