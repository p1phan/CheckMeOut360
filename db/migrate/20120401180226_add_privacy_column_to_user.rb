class AddPrivacyColumnToUser < ActiveRecord::Migration
  def change
    add_column :users, :privacy, :string, default: "protected"
  end
end