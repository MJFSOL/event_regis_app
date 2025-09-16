class Admin::EventsController < ApplicationController
  before_action :require_admin
  protect_from_forgery except: :bulk_delete
  def index
    @events=Event.all
     if params[:search].present?
      @events = @events.where("event_name ILIKE ? OR location ILIKE ?", "%#{params[:search]}%", "%#{params[:search]}%")
     end
  end

  def bulk_delete
    Event.where(id: params[:event_ids]).destroy_all
    redirect_to admin_events_path, notice: "Selected events have been deleted."
  end
end
