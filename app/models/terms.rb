class Terms < ActiveRecord::Base

  attr_accessor :parsed

  validates :name, :origin_name, presence: true, uniqueness: true
  validates :url, presence: true

  def full_name
    "#{name} (#{origin_name})"
  end

end
