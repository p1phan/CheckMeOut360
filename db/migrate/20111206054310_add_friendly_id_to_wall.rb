class AddFriendlyIdToWall < ActiveRecord::Migration
  def change
    add_column :walls, :wall_name, :string
    add_column :walls, :slug, :string
    add_index :walls, :slug, :unique => true
  end
end