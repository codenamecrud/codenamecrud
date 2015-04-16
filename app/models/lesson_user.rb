class LessonUser < ActiveRecord::Base
  belongs_to :user
  belongs_to :lesson
  has_paper_trail

  after_create :record_object
  before_save :check_completion

  private

  def record_object
    PaperTrail::Version.last.update(object: self.lesson_id)
  end

  def check_completion
    user_lesson_doubles = PaperTrail::Version.where(whodunnit: self.user_id, object: self.lesson_id)
    if user_lesson_doubles.count > 0
      user_lesson_doubles.delete_all
    end
  end
end
