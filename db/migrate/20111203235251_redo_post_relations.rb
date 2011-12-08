class RedoPostRelations < ActiveRecord::Migration
  def up
    remove_column :posts, :creator_id
    add_column :posts, :wall_id, :integer
  end

  def down
  end
end