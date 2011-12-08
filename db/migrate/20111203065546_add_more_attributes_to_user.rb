class AddMoreAttributesToUser < ActiveRecord::Migration
  def change
    add_column :users, :major, :string
    add_column :users, :school, :string
    add_column :users, :location, :string
    add_column :users, :employer, :string
    add_column :users, :facebook_site, :string
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :position, :string
  end
end