class CleanUpProfileTable < ActiveRecord::Migration
  def change
    remove_column :profiles, :major
    remove_column :profiles, :school
    remove_column :profiles, :employer
    remove_column :profiles, :facebook_site
    remove_column :profiles, :position
    add_column :profiles, :permalink, :string
  end
end