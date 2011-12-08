class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string :first_name
      t.string :last_name
      t.string :profile_picture 
      t.string :major
      t.string :school
      t.string :location
      t.string :employer
      t.string :facebook_site
      t.string :position
      t.references :user
      t.timestamps
    end
  end
end
