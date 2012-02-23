class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :omniauthable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  before_save :create_wall_and_profile
  has_many :posts, inverse_of: :user, :dependent => :destroy
  has_one :wall, inverse_of: :user, :dependent => :destroy
  has_one :profile, inverse_of: :user, :dependent => :destroy
  has_many :places, :through => :checkins
  has_and_belongs_to_many :checkins
  
  accepts_nested_attributes_for :wall
  accepts_nested_attributes_for :profile
  accepts_nested_attributes_for :posts
  
  scope :active, where("token is NOT NULL")
  scope :inactive, where("token is NULL")
  
  def create_wall_and_profile
    unless self.wall
      wall = self.build_wall 
      wall.slug = wall.set_next_available_wall_name(email.split("@").first)
    end
    self.build_profile unless self.profile
  end

  def self.find_for_facebook_oauth(access_token, signed_in_resource=nil)
    data = access_token.extra.raw_info
    if user = User.where("email = ? or uid = ?", data.email, access_token['uid']).first
      unless user.token
        user.email = data.email
        user.uid = access_token['uid']
        user.token = access_token['credentials']['token']
        user.save
      end
      @profile = Profile.find_or_initialize_by_user_id(user.id)
      update_facebook_profile(user, data, access_token)
      @profile.save
      user
    else
      user = User.new(:email => data.email)
      user.uid = access_token['uid']
      user.token = access_token['credentials']['token']
      @profile = user.build_profile
      update_facebook_profile(user, data, access_token)
      user.save!(:validate => false)
      user
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

  def self.update_facebook_profile(user, data, access_token)
    @profile.remote_profile_picture_url = access_token.info.image.gsub("square", "large")
    @profile.major = data.education.try(:last).try(:concentration).try(:first).try(:name)
    @profile.school = data.education.try(:last).try(:school).try(:name)
    @profile.first_name = data.first_name
    @profile.last_name = data.last_name
    @profile.employer = data.work.try(:first).try(:employer).try(:name)
    @profile.position = data.work.try(:first).try(:position).try(:name)
    @profile.location = data.work.try(:first).try(:location).try(:name)
    @profile.facebook_site = data.link
  end
  
  def places_from_checkins
  end
  
  def self.me
    User.find_by_email("quyminhphan@gmail.com")
  end

end
