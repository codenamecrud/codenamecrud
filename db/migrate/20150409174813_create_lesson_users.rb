class CreateLessonUsers < ActiveRecord::Migration
  def change
    create_table :lesson_users do |t|
      t.integer :lesson_id, index: true
      t.integer :user_id, index: true
      t.boolean :completed

      t.timestamps null: false
    end
  end
end
