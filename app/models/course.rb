class Course < ActiveRecord::Base
  include FriendlyId
  friendly_id :slug
  validates :title, presence: true
  validates :description, presence: true

  serialize :you_learn
  serialize :you_build
end
