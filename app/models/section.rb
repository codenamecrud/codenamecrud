class Section < ActiveRecord::Base
  include FriendlyId
  include Ordering

  friendly_id :slug

  belongs_to :course
  has_many :lessons

  validates :title, :slug, :description, :course_id, presence: true

  def next_lesson_in_the_section(section_lesson)
    lessons.find_by(id: section_lesson.id + 1)
  end

end
