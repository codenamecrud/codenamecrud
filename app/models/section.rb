class Section < ActiveRecord::Base
  include FriendlyId
  friendly_id :slug

  belongs_to :course
  has_many :lessons

  validates :title, :slug, :description, :course_id, presence: true
end
