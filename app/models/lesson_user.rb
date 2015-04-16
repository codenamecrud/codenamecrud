class LessonUser < ActiveRecord::Base
  belongs_to :user
  belongs_to :lesson
  has_paper_trail

  after_create :record_object

  private

  def record_object
    PaperTrail::Version.last.update(object: self.lesson_id)
  end
end
