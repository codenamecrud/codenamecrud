class ChangeDisplayEmailDefaultValueForUsers < ActiveRecord::Migration
  def change
    change_column_default :users, :display_email, false
  end
end
