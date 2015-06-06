# require 'paper_trail/frameworks/active_record/models/paper_trail/version'
if !Rails.env.development? || $0 =~ /rake$/
  PaperTrail::Rails::Engine.eager_load!
end

module PaperTrail
  class Version < ActiveRecord::Base
    include ::Concerns::Paginator
  end
end
