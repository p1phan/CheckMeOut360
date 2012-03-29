class AddIndexToTables < ActiveRecord::Migration
  def change
    add_index :checkins, :facebook_checkin_id
    add_index :checkins, :place_id
    
    add_index :places, :facebook_place_id
    add_index :places, :facebook_id
    
    add_index :users, :uid
    
    add_index :checkins_users, :checkin_id
    add_index :checkins_users, :user_id
  end
end