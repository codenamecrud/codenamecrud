class Lesson < ActiveRecord::Base
  include FriendlyId
  include Ordering
  friendly_id :slug

  has_paper_trail

  belongs_to :section
  belongs_to :course
  has_many :lesson_users
  has_many :users, through: :lesson_users

  validates :title, :slug, :description, :section_id, :position, presence: true

  def next
    course.lessons.where('position > ?', position).order(position: :asc).first
  end

  def previous
    course.lessons.where('position < ?', position).order(position: :desc).first
  end

  def get_section_lessons(course)
    section = course.lessons.find(id).section
    section.lessons.where(course_id: course.id).order(:id)
  end
end
