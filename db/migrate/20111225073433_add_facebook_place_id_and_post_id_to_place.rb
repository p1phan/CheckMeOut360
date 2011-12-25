class AddFacebookPlaceIdAndPostIdToPlace < ActiveRecord::Migration
  def change
    add_column :places, :facebook_place_id, :string
    add_column :places, :facebook_id, :string
  end
end