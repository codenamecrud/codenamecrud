class AddPositionsToCoursesSectionsAndLessons < ActiveRecord::Migration
  def change
    add_column :courses, :position, :integer, default: 0
    add_column :lessons, :position, :integer, default: 0
    add_column :sections, :position, :integer, default: 0
  end
end
