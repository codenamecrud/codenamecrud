class CreateLessons < ActiveRecord::Migration
  def change
    create_table :lessons do |t|
      t.string :title
      t.string :slug
      t.string :description
      t.integer :section_id, index: true
      t.boolean :is_project, default: false

      t.timestamps null: false
    end
  end
end
