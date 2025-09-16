class UserController < ApplicationController
  before_action :require_login
  def dashboard
    @events = current_user.events.all
  end
end
