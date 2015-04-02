class Section < ActiveRecord::Base
  belongs_to :course

  validates :title, :slug, :description, :course_id, presence: true
end
