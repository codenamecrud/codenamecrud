class Course < ActiveRecord::Base
  include FriendlyId
  friendly_id :slug

  has_many :sections
  has_many :lesson

  validates :title, :slug, :short_description, :description, presence: true

  serialize :you_learn
  serialize :you_build
end
