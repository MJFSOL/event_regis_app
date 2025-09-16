class RegistrationsController < ApplicationController
  before_action :require_login
  def create
    @event = Event.find(params[:event_id])
    @registration = @event.registrations.new(registration_params)
    if @registration.save
      redirect_to @event
    else
      @registrations = @event.registrations
      render "events/show", status: :unprocessable_entity
    end
  end

  def edit
    @event = Event.find(params[:event_id])
    @registration = @event.registrations.find(params[:id])
  end

  def update
    @event = Event.find(params[:event_id])
    @registration = @event.registrations.find(params[:id])
    if @registration.update(registration_params)
        redirect_to @event, notice: "Attendee was successfully updated"
    else
        render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @event = Event.find(params[:event_id])
    @registration = @event.registrations.find(params[:id])
    @registration.destroy
    redirect_to @event, notice: "Attendee was successfully deleted."
  end

  private # Corrected and singular private block

  def registration_params
    params.require(:registration).permit(:attendee_name, :attendee_email)
  end
end
