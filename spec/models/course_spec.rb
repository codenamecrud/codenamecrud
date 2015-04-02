require 'rails_helper'

describe Course do
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:slug) }
  it { should validate_presence_of(:you_build) }
  it { should validate_presence_of(:you_learn) }
  it { should validate_presence_of(:description) }
  it { should validate_presence_of(:short_description) }
  it { should have_many(:sections) }
end
