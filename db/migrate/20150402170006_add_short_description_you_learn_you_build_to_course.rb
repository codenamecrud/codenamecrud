class AddShortDescriptionYouLearnYouBuildToCourse < ActiveRecord::Migration
  def change
    add_column :courses, :short_description, :text
    add_column :courses, :you_learn, :text
    add_column :courses, :you_build, :text
  end
end
