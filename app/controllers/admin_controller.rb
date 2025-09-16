class AdminController < ApplicationController
  before_action :require_admin
  def dashboard
    @total_events = Event.count
    @total_registration = Registration.count
  end
end
