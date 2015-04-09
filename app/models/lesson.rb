class Lesson < ActiveRecord::Base
  include FriendlyId
  friendly_id :slug

  belongs_to :section
  belongs_to :course

  validates :title, :slug, :description, :section_id, presence: true
end
