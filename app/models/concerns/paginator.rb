module Concerns
  module Paginator
    extend ActiveSupport::Concern

    included do
      scope :paginator, -> (page) { paginate(page: page, per_page: 20) }
    end
  end
end