class CreateCheckins < ActiveRecord::Migration
  def change
    create_table :checkins do |t|
      t.string :facebook_checkin_id
      t.string :message
      t.datetime :created_at
      t.references :place
    end
  end
end
