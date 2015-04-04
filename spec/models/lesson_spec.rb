require 'rails_helper'

describe Lesson do
  it { should belong_to(:section) }
end
