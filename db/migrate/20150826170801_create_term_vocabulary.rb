class CreateTermVocabulary < ActiveRecord::Migration
  def change
    create_table :terms do |t|
      t.string   :name, :null => false
      t.string   :origin_name, :null => false
      t.text     :description
      t.string   :url, :null => false
    end
  end
end
