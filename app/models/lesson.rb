class Lesson < ActiveRecord::Base
  include FriendlyId
  friendly_id :slug

  has_paper_trail

  belongs_to :section
  belongs_to :course
  has_many :lesson_users
  has_many :users, through: :lesson_users

  validates :title, :slug, :description, :section_id, presence: true

  scope :order_by_position, -> { all.order(position: :asc) }

  def next
    self.course.lessons.where('id > ?', id).first
  end

  def previous
    self.course.lessons.where('id < ?', id).last
  end
end
