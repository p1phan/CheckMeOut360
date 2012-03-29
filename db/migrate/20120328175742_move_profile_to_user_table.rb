class MoveProfileToUserTable < ActiveRecord::Migration
  def change
    add_column :users, :picture, :string
    add_column :users, :location, :string
  end
end