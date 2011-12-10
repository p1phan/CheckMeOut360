class UsersPlacesTable < ActiveRecord::Migration
  def self.up
    create_table :places_users, :id => false do |t|
      t.references :user
      t.references :place

      t.timestamps
    end
  end
  
  def self.down
    drop_table :places_users
  end
end
