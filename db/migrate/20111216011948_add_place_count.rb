class AddPlaceCount < ActiveRecord::Migration
  def up
    add_column :places, :count, :integer, :default => 0
  end

  def down
    remove_column :places, :count
  end
end