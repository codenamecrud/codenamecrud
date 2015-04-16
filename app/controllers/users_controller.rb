class UsersController < ApplicationController
  def activity
    @activity = PaperTrail::Version.all
  end
end
