class Section < ActiveRecord::Base
  include FriendlyId
  include Ordering

  friendly_id :slug

  belongs_to :course
  has_many :lessons

  validates :title, :slug, :description, :course_id, presence: true
end
