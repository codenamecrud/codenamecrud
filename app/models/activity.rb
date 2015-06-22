class Activity
  PER_PAGE = 20

  def self.user_lessons(user = nil, page)
    user_data = user.present? ? { whodunnit: user.id.to_s} : {}

    PaperTrail::Version.where({ item_type: 'LessonUser' }.merge(user_data))
      .order(created_at: :desc)
      .paginate(page: page, per_page: PER_PAGE)
  end
end
