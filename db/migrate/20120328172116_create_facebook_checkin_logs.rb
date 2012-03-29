class CreateFacebookCheckinLogs < ActiveRecord::Migration
  def change
    create_table :facebook_checkin_logs do |t|
      t.string :current
      t.string :next
      t.string :previous
      t.string :done
      t.references :user
      t.timestamps
    end
  end
end
