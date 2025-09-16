require "csv"

class Admin::RegistrationsController < ApplicationController
  before_action :require_admin
  protect_from_forgery except: :bulk_delete 
  def index
    @registrations = Registration.all
    if params[:search].present?
      @registrations = @registrations.joins(:event).where(
        "registrations.attendee_name ILIKE ? OR registrations.attendee_email ILIKE ? OR events.event_name ILIKE ?",
        "%#{params[:search]}%", "%#{params[:search]}%", "%#{params[:search]}%"
      )
    end
  end
  def bulk_delete
    Registration.where(id: params[:registration_ids]).destroy_all
    redirect_to admin_registrations_path, notice: "Selected registrations have been deleted."
  end

  def export
    @registrations = Registration.all
    respond_to do |format|
      format.csv { send_data @registrations.to_csv, filename: "registrations-#{Date.today}.csv" }
    end
  end
end
