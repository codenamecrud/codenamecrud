require 'rails_helper'

describe Lesson do
  it { should belong_to(:section) }
  it { should have_many(:users).through(:lesson_users) }
end
