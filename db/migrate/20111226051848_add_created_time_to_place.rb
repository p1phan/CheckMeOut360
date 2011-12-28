class AddCreatedTimeToPlace < ActiveRecord::Migration
  def change
    add_column :places, :time_created, :datetime
    # add_column :posts
  end
end