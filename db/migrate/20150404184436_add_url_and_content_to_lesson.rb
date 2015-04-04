class AddUrlAndContentToLesson < ActiveRecord::Migration
  def change
    add_column :lessons, :url, :string
    add_column :lessons, :content, :text
  end
end
