class AddSlugToCourse < ActiveRecord::Migration
  def change
    add_column :courses, :slug, :string
  end
end
