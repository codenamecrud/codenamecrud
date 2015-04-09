class CreateLessonsUsersTable < ActiveRecord::Migration
  def change
    create_table :lessons_users_tables do |t|
      t.integer :lesson_id
      t.integer :user_id
      t.boolean :completed
    end
  end
end
