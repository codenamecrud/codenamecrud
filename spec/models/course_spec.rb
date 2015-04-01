require 'rails_helper'

describe Course do
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:description) }
end
