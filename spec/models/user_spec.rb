require 'rails_helper'

describe User do
  it { should have_many(:lessons).through(:lesson_users) }
end
