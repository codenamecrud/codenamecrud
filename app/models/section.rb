class Section < ActiveRecord::Base
  include FriendlyId
  friendly_id :slug

  belongs_to :course

  validates :title, :slug, :description, :course_id, presence: true
end
