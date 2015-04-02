class Course < ActiveRecord::Base
  validates :title, presence: true
  validates :description, presence: true

  serialize :you_learn
  serialize :you_build
end
