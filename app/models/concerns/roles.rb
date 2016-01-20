module Concerns
  module Roles
    extend ActiveSupport::Concern

    [:user?, :admin?].each do |method_name|
      define_method method_name do
        role == method_name.to_s.chomp('?')
      end
    end
  end
end
