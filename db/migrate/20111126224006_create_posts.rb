class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.integer :user_id
      t.integer :creator_id
      t.string :message

      t.timestamps
    end
  end
end
