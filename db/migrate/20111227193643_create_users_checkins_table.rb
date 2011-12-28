class CreateUsersCheckinsTable < ActiveRecord::Migration
  def self.up
    create_table :checkins_users, :id => false do |t|
      t.references :user
      t.references :checkin

      t.timestamps
    end
  end
  
  def self.down
    drop_table :checkins_users
  end
end
