require 'rails_helper'

describe LessonsController do
  let!(:course) { create(:course) }
  let!(:lesson) { create(:lesson, course: course) }
  let!(:course) { create(:course) }

  describe "POST #toggle_check" do
    pending "adds lesson to user's lessons"
  end
end
