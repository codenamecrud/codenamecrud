PaperTrail::Rails::Engine.eager_load! unless Rails.env.development?

module PaperTrail
  class Version < ActiveRecord::Base
    include ::Concerns::Paginator
  end
end