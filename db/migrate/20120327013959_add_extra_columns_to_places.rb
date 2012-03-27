class AddExtraColumnsToPlaces < ActiveRecord::Migration
  def change
    add_column :places, :category, :string
    add_column :places, :description, :text
    add_column :places, :picture, :string
    add_column :places, :likes, :integer
    add_column :places, :checkin_count, :integer
  end
end