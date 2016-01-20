class AddIndexesIntoDb < ActiveRecord::Migration
  def change
    add_index :lessons, :course_id
    add_index :lessons_users_tables, :lesson_id
    add_index :lessons_users_tables, :user_id
  end
end
