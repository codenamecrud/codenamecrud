require 'rails_helper'

describe Section do
  it { should belong_to(:course) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:slug) }
  it { should validate_presence_of(:description) }

end
