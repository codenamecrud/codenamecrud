class CreateSections < ActiveRecord::Migration
  def change
    create_table :sections do |t|
      t.string :title
      t.string :slug
      t.integer :course_id, index: true
      t.text :description

      t.timestamps null: false
    end
  end
end
