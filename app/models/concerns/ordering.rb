module Ordering
  extend ActiveSupport::Concern

  included do
    scope :order_by_position, -> { all.order(position: :asc) }
  end
end
