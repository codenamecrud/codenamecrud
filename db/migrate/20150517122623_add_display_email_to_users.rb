class AddDisplayEmailToUsers < ActiveRecord::Migration
  def change
    add_column :users, :display_email, :boolean, null: false, default: false
  end
end
