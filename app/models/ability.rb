class Ability
  include CanCan::Ability

  def initialize(current_user, user)
    can [:show, :index, :map], :all if has_access_rights(current_user, user)
  end
  
  def has_access_rights(current_user, user)
    if user.privacy == User::PUBLIC
      return true
    elsif user.privacy == User::PROTECTED
      if current_user && current_user.friend_with(user)
        return true
      else
        return false
      end
    else
      return true if current_user.id = user.id
    end
    return false
  end
end
