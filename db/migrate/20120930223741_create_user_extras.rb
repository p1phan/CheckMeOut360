class CreateUserExtras < ActiveRecord::Migration
  def change
    create_table :user_extras do |t|
      t.string :name
      t.string :extra
      t.boolean :link, :default => false
      t.integer :user_id
      t.timestamps
    end
  end
end
