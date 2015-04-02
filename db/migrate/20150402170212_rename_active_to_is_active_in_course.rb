class RenameActiveToIsActiveInCourse < ActiveRecord::Migration
  def change
    rename_column :courses, :active, :is_active
  end
end
