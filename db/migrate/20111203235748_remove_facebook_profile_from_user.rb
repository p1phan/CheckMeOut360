class RemoveFacebookProfileFromUser < ActiveRecord::Migration
  def up
    remove_column :users, :first_name
    remove_column :users, :last_name
    remove_column :users, :profile_picture
    remove_column :users, :major
    remove_column :users, :school
    remove_column :users, :location
    remove_column :users, :employer
    remove_column :users, :facebook_site
    remove_column :users, :position
  end

  def down
  end
end